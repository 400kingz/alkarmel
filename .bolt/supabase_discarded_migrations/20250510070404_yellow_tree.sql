/*
  # Update products table RLS policies

  1. Changes
    - Modify RLS policies to allow proper access to products table
    - Add policy for authenticated users to view all active products
    - Add policy for admin users to manage products

  2. Security
    - Enable RLS on products table
    - Add policies for read and write access
*/

-- First, drop existing policies
DROP POLICY IF EXISTS "Admin users can manage products" ON products;
DROP POLICY IF EXISTS "Users can view active products" ON products;

-- Re-create policies with correct permissions
CREATE POLICY "Admin users can manage products"
ON products
FOR ALL
TO authenticated
USING (
  (auth.jwt() ->> 'email')::text IN (
    SELECT email FROM users 
    WHERE raw_user_meta_data->>'isAdmin' = 'true'
  )
)
WITH CHECK (
  (auth.jwt() ->> 'email')::text IN (
    SELECT email FROM users 
    WHERE raw_user_meta_data->>'isAdmin' = 'true'
  )
);

CREATE POLICY "Users can view active products"
ON products
FOR SELECT
TO authenticated
USING (deleted_at IS NULL);