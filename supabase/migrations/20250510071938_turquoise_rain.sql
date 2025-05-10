/*
  # Update RLS policies for products and orders

  1. Changes
    - Drop and recreate policies for products table
    - Update orders table policies to use admins table
    - Add policy checks to prevent duplicates
*/

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