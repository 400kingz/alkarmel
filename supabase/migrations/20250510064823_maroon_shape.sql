/*
  # Create products table

  1. New Table
    - `products`: Stores product information
      - `id` (uuid, primary key)
      - `name` (text)
      - `description` (text)
      - `price` (numeric)
      - `category` (text)
      - `image` (text)
      - `stripe_product_id` (text)
      - `stripe_price_id` (text)
      - Standard timestamps and soft delete
  
  2. Security
    - Enable RLS on `products` table
    - Add policies for:
      - Authenticated users to read products
      - Admin users to manage products
*/

CREATE TABLE IF NOT EXISTS products (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name text NOT NULL,
    description text,
    price numeric(10,2) NOT NULL CHECK (price >= 0),
    category text,
    image text,
    stripe_product_id text,
    stripe_price_id text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    deleted_at timestamp with time zone DEFAULT null
);

ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- Allow all authenticated users to view non-deleted products
CREATE POLICY "Users can view active products" 
    ON products
    FOR SELECT
    TO authenticated
    USING (deleted_at IS NULL);

-- Allow admin users to manage products
CREATE POLICY "Admin users can manage products" 
    ON products
    FOR ALL
    TO authenticated
    USING (
        EXISTS (
            SELECT 1
            FROM auth.users
            WHERE auth.uid() = id
            AND raw_user_meta_data->>'isAdmin' = 'true'
        )
    );