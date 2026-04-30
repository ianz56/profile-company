-- Create the wishlist table
CREATE TABLE wishlist (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  product_id BIGINT REFERENCES products(id) ON DELETE CASCADE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, product_id)
);

-- Enable Row Level Security (RLS)
ALTER TABLE wishlist ENABLE ROW LEVEL SECURITY;

-- Create a policy that allows users to manage their own wishlist
CREATE POLICY "Users can manage their own wishlist" ON wishlist
  FOR ALL USING (auth.uid() = user_id);

-- Create a policy that allows users to read products in their wishlist (joining with products)
-- This is usually handled by the products table policy, but if products had stricter RLS, 
-- we might need specific logic here. For now, public read on products is enough.
