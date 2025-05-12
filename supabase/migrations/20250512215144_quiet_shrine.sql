/*
  # Add admin user to admins table
  
  This migration:
  1. Safely adds the existing admin@admin.com user to the admins table
  2. Includes error handling and validation
  3. Uses a transaction to ensure data consistency
*/

BEGIN;

-- Add the existing admin user to the admins table if they exist
DO $$
DECLARE
  admin_user_id UUID;
BEGIN
  -- Get the admin user's ID
  SELECT id INTO admin_user_id 
  FROM auth.users 
  WHERE email = 'admin@admin.com'
  LIMIT 1;

  -- If admin user exists and is not already in admins table, add them
  IF admin_user_id IS NOT NULL THEN
    INSERT INTO public.admins (user_id)
    VALUES (admin_user_id)
    ON CONFLICT (user_id) DO NOTHING;
  ELSE
    RAISE NOTICE 'Admin user not found in auth.users table';
  END IF;
END $$;

COMMIT;