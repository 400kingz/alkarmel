/*
  # Add admin user
  
  1. Creates an admin user with email admin@admin.com
  2. Adds the user to the admins table
*/

-- Create admin user in auth.users
DO $$
DECLARE
  admin_user_id UUID;
BEGIN
  -- Insert the admin user and get their ID
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
  RETURNING id INTO admin_user_id;
  
  -- If user was created or already exists, ensure they're in admins table
  IF admin_user_id IS NULL THEN
    -- Get ID of existing user
    SELECT id INTO admin_user_id FROM auth.users WHERE email = 'admin@admin.com';
  END IF;
  
  -- Add user to admins table
  IF admin_user_id IS NOT NULL THEN
    INSERT INTO admins (user_id)
    VALUES (admin_user_id)
    ON CONFLICT (user_id) DO NOTHING;
  END IF;
END $$;