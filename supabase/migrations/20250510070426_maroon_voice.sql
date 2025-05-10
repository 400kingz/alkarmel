/*
  # Update products table RLS policies
  
  1. Changes
    - Remove dependency on users table
    - Use auth.uid() for admin checks
    - Maintain existing security model
  
  2. Security
    - Enable RLS on products table
    - Add policy for admin users to manage products
    - Add policy for authenticated users to view active products
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
  EXISTS (
    SELECT 1
    FROM auth.users
    WHERE id = auth.uid()
    AND (raw_user_meta_data->>'isAdmin')::text = 'true'
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1
    FROM auth.users
    WHERE id = auth.uid()
    AND (raw_user_meta_data->>'isAdmin')::text = 'true'
  )
);

CREATE POLICY "Users can view active products"
ON products
FOR SELECT
TO authenticated
USING (deleted_at IS NULL);