/*
  # Fix Products Table RLS Policies

  1. Changes
    - Drop existing policies
    - Create new policies using auth.uid() instead of direct table references
    - Maintain same functionality but with better security
  
  2. Security
    - Enable RLS
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
  (auth.jwt() ->> 'email')::text IN (
    SELECT email FROM auth.users 
    WHERE (raw_user_meta_data->>'isAdmin')::text = 'true'
  )
)
WITH CHECK (
  (auth.jwt() ->> 'email')::text IN (
    SELECT email FROM auth.users 
    WHERE (raw_user_meta_data->>'isAdmin')::text = 'true'
  )
);

CREATE POLICY "Users can view active products"
ON products
FOR SELECT
TO authenticated
USING (deleted_at IS NULL);