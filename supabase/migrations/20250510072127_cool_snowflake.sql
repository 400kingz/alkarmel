/*
  # Add admin user

  1. Changes
    - Insert admin user into auth.users table
    - Add admin user to admins table
  
  2. Security
    - Admin user will have full access via RLS policies
*/

-- First create the admin user in auth.users
INSERT INTO auth.users (
  instance_id,
  id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  created_at,
  updated_at
)
VALUES (
  '00000000-0000-0000-0000-000000000000',
  gen_random_uuid(),
  'authenticated',
  'authenticated',
  'admin@admin.com',
  crypt('admin', gen_salt('bf')),
  now(),
  now(),
  now()
)
ON CONFLICT (email) DO NOTHING
RETURNING id INTO admin_id;

-- Then add the user to the admins table
DO $$
DECLARE
  admin_user_id UUID;
BEGIN
  SELECT id INTO admin_user_id FROM auth.users WHERE email = 'admin@admin.com';
  
  IF admin_user_id IS NOT NULL THEN
    INSERT INTO admins (user_id)
    VALUES (admin_user_id)
    ON CONFLICT (user_id) DO NOTHING;
  END IF;
END $$;