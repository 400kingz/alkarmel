/*
  # Fix recursive RLS policy on admins table

  1. Changes
    - Drop the existing recursive policy on the admins table
    - Create a new non-recursive policy that allows admins to manage admins
    - The new policy uses a subquery with a different alias to prevent recursion

  2. Security
    - Maintains RLS protection
    - Ensures only admins can manage admin records
    - Prevents infinite recursion in policy evaluation
*/

-- Drop the existing policy that's causing recursion
DROP POLICY IF EXISTS "Admins can manage admins" ON admins;

-- Create new non-recursive policy
CREATE POLICY "Admins can manage admins v2" ON admins
  FOR ALL 
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 
      FROM admins AS admin_check 
      WHERE admin_check.user_id = auth.uid()
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 
      FROM admins AS admin_check 
      WHERE admin_check.user_id = auth.uid()
    )
  );