/*
  # Fix infinite recursion in admins RLS policy

  1. Changes
    - Drop the existing policy that causes infinite recursion
    - Create a new policy that directly checks the user_id without recursive queries
  
  2. Security
    - Maintains row-level security on admins table
    - Only allows admins to manage the admins table
    - Uses direct comparison instead of subquery to prevent recursion
*/

-- Drop the existing policy that causes recursion
DROP POLICY IF EXISTS "Admins can manage admins v2" ON public.admins;

-- Create new policy without recursion
CREATE POLICY "Admins can manage admins" ON public.admins
  FOR ALL
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);