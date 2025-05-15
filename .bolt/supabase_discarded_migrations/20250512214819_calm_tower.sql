/*
  # Add admin rights functionality

  1. New Tables
    - `admins` table to track admin users
      - `user_id` (uuid, primary key, references users.id)

  2. Security
    - Enable RLS on `admins` table
    - Add policy for admins to manage other admins
    - Add policy for admins to manage products

  3. Initial Data
    - Add initial admin user
*/

-- Create admins table
CREATE TABLE IF NOT EXISTS admins (
  user_id uuid PRIMARY KEY REFERENCES auth.users(id)
);

-- Enable RLS
ALTER TABLE admins ENABLE ROW LEVEL SECURITY;

-- Allow admins to manage other admins
CREATE POLICY "Admins can manage admins"
  ON admins
  FOR ALL
  TO authenticated
  USING (
    auth.uid() IN (
      SELECT user_id FROM admins
    )
  );

-- Add initial admin user
INSERT INTO admins (user_id)
SELECT id
FROM auth.users
WHERE email = 'admin@admin.com'
ON CONFLICT (user_id) DO NOTHING;

-- Update products table policies to allow admin management
CREATE POLICY "Admin users can delete products"
  ON products
  FOR DELETE
  TO authenticated
  USING (
    auth.uid() IN (
      SELECT user_id FROM admins
    )
  );

CREATE POLICY "Admin users can insert products"
  ON products
  FOR INSERT
  TO authenticated
  WITH CHECK (
    auth.uid() IN (
      SELECT user_id FROM admins
    )
  );

CREATE POLICY "Admin users can update products"
  ON products
  FOR UPDATE
  TO authenticated
  USING (
    auth.uid() IN (
      SELECT user_id FROM admins
    )
  )
  WITH CHECK (
    auth.uid() IN (
      SELECT user_id FROM admins
    )
  );

-- Allow all authenticated users to view active products
CREATE POLICY "Users can view active products"
  ON products
  FOR SELECT
  TO authenticated
  USING (deleted_at IS NULL);