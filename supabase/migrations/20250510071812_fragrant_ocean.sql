/*
  # Set up admin system and update RLS policies
  
  1. New Tables
    - `admins` table to store admin user IDs
      - `user_id` (uuid, primary key, references auth.users)
  
  2. Security Changes
    - Enable RLS on admins table
    - Add policy for admins to manage admins table
    - Update product policies to use admins table
    - Update orders policies to use admins table
  
  3. Changes
    - Drop existing policies
    - Create new policies using admins table for authorization
*/

-- Create admins table
CREATE TABLE IF NOT EXISTS admins (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id)
);

-- Enable RLS on admins table
ALTER TABLE admins ENABLE ROW LEVEL SECURITY;

-- Allow admins to manage the admins table
CREATE POLICY "Admins can manage admins"
ON admins
FOR ALL
TO authenticated
USING (auth.uid() IN (SELECT user_id FROM admins));

-- Drop existing product policies
DROP POLICY IF EXISTS "Admin users can insert products" ON products;
DROP POLICY IF EXISTS "Admin users can update products" ON products;
DROP POLICY IF EXISTS "Admin users can delete products" ON products;
DROP POLICY IF EXISTS "Users can view active products" ON products;

-- Create new policies using admins table
CREATE POLICY "Users can view active products"
ON products
FOR SELECT
TO authenticated
USING (deleted_at IS NULL);

CREATE POLICY "Admin users can insert products"
ON products
FOR INSERT
TO authenticated
WITH CHECK (auth.uid() IN (SELECT user_id FROM admins));

CREATE POLICY "Admin users can update products"
ON products
FOR UPDATE
TO authenticated
USING (auth.uid() IN (SELECT user_id FROM admins))
WITH CHECK (auth.uid() IN (SELECT user_id FROM admins));

CREATE POLICY "Admin users can delete products"
ON products
FOR DELETE
TO authenticated
USING (auth.uid() IN (SELECT user_id FROM admins));

-- Update orders table policies
DROP POLICY IF EXISTS "Admin users can manage orders" ON orders;

CREATE POLICY "Admin users can manage orders"
ON orders
FOR ALL
TO authenticated
USING (auth.uid() IN (SELECT user_id FROM admins));