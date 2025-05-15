/*
  # Add initial admin user

  1. Changes
    - Insert admin@admin.com as an admin user
    - Add RLS policies for admin table
*/

-- First, create the admin user if it doesn't exist
DO $$ 
BEGIN
  -- Insert the admin user if it doesn't exist
  INSERT INTO auth.users (
    email,
    encrypted_password,
    email_confirmed_at,
    raw_app_meta_data,
    raw_user_meta_data,
    created_at,
    updated_at,
    role,
    confirmation_token
  )
  VALUES (
    'admin@admin.com',
    crypt('admin', gen_salt('bf')),
    now(),
    '{"provider":"email","providers":["email"]}',
    '{}',
    now(),
    now(),
    'authenticated',
    ''
  )
  ON CONFLICT (email) DO NOTHING;

  -- Get the admin user's ID
  WITH admin_user AS (
    SELECT id FROM auth.users WHERE email = 'admin@admin.com' LIMIT 1
  )
  -- Add the user to the admins table
  INSERT INTO public.admins (user_id)
  SELECT id FROM admin_user
  ON CONFLICT (user_id) DO NOTHING;
END $$;