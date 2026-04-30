-- 1. Create orders table IF NOT EXISTS (Adjusted to BIGINT to match your existing table)
CREATE TABLE IF NOT EXISTS orders (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  full_name TEXT NOT NULL,
  phone TEXT NOT NULL,
  address TEXT NOT NULL,
  city TEXT NOT NULL,
  province TEXT NOT NULL,
  postal_code TEXT NOT NULL,
  total_price NUMERIC NOT NULL,
  status TEXT DEFAULT 'pending',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Create order_items table IF NOT EXISTS (Using BIGINT for order_id)
CREATE TABLE IF NOT EXISTS order_items (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  order_id BIGINT REFERENCES orders(id) ON DELETE CASCADE NOT NULL,
  product_id BIGINT REFERENCES products(id) ON DELETE SET NULL,
  product_name TEXT NOT NULL,
  quantity INTEGER NOT NULL,
  price_at_purchase NUMERIC NOT NULL,
  image_url TEXT
);

-- 3. Create reviews table IF NOT EXISTS
CREATE TABLE IF NOT EXISTS reviews (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  product_id BIGINT REFERENCES products(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  user_name TEXT NOT NULL,
  rating INTEGER CHECK (rating >= 1 AND rating <= 5) NOT NULL,
  comment TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security (RLS)
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;

-- Drop existing policies to avoid "already exists" errors
DROP POLICY IF EXISTS "Users can view their own orders" ON orders;
DROP POLICY IF EXISTS "Users can insert their own orders" ON orders;
DROP POLICY IF EXISTS "Users can view their own order items" ON order_items;
DROP POLICY IF EXISTS "Users can insert their own order items" ON order_items;
DROP POLICY IF EXISTS "Anyone can read reviews" ON reviews;
DROP POLICY IF EXISTS "Users can manage their own reviews" ON reviews;

-- Re-create RLS Policies
CREATE POLICY "Users can view their own orders" ON orders 
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own orders" ON orders 
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can view their own order items" ON order_items 
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM orders 
      WHERE orders.id = order_items.order_id 
      AND orders.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can insert their own order items" ON order_items 
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM orders 
      WHERE orders.id = order_items.order_id 
      AND orders.user_id = auth.uid()
    )
  );

CREATE POLICY "Anyone can read reviews" ON reviews 
  FOR SELECT USING (true);

CREATE POLICY "Users can manage their own reviews" ON reviews 
  FOR ALL USING (auth.uid() = user_id);
