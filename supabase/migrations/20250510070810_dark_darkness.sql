/*
  # Fix Products Table RLS Policies

  1. Changes
    - Drop existing RLS policies for products table
    - Create new policies that properly handle admin access
    - Add separate policies for different operations (select, insert, update, delete)
    
  2. Security
    - Enable RLS on products table
    - Add policies for authenticated users
    - Add specific policies for admin users
*/

-- First, drop existing policies
DROP POLICY IF EXISTS "Admin users can manage products" ON products;
DROP POLICY IF EXISTS "Users can view active products" ON products;

-- Enable RLS
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- Policy for viewing products (all authenticated users can view non-deleted products)
CREATE POLICY "Users can view active products"
ON products
FOR SELECT
TO authenticated
USING (deleted_at IS NULL);

-- Policy for admin users to insert products
CREATE POLICY "Admin users can insert products"
ON products
FOR INSERT
TO authenticated
WITH CHECK (
  auth.jwt()->>'email' IN (
    SELECT email FROM auth.users 
    WHERE raw_user_meta_data->>'isAdmin' = 'true'
  )
);

-- Policy for admin users to update products
CREATE POLICY "Admin users can update products"
ON products
FOR UPDATE
TO authenticated
USING (
  auth.jwt()->>'email' IN (
    SELECT email FROM auth.users 
    WHERE raw_user_meta_data->>'isAdmin' = 'true'
  )
)
WITH CHECK (
  auth.jwt()->>'email' IN (
    SELECT email FROM auth.users 
    WHERE raw_user_meta_data->>'isAdmin' = 'true'
  )
);

-- Policy for admin users to delete products
CREATE POLICY "Admin users can delete products"
ON products
FOR DELETE
TO authenticated
USING (
  auth.jwt()->>'email' IN (
    SELECT email FROM auth.users 
    WHERE raw_user_meta_data->>'isAdmin' = 'true'
  )
);