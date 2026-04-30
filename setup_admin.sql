-- 1. Add is_admin column to profiles table
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS is_admin BOOLEAN DEFAULT FALSE;

-- 2. Update Orders Policies to allow Admins to view ALL orders
DROP POLICY IF EXISTS "Users can view their own orders" ON orders;
CREATE POLICY "Users can view their own orders or admins can view all" ON orders
  FOR SELECT USING (
    auth.uid() = user_id 
    OR (SELECT is_admin FROM profiles WHERE id = auth.uid())
  );

-- 3. Update Order Items Policies to allow Admins to view ALL items
DROP POLICY IF EXISTS "Users can view their own order items" ON order_items;
CREATE POLICY "Users can view their own order items or admins can view all" ON order_items
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM orders 
      WHERE orders.id = order_items.order_id 
      AND (orders.user_id = auth.uid() OR (SELECT is_admin FROM profiles WHERE id = auth.uid()))
    )
  );

-- 4. Allow Admins to UPDATE order status
DROP POLICY IF EXISTS "Admins can update orders" ON orders;
CREATE POLICY "Admins can update orders" ON orders
  FOR UPDATE USING (
    (SELECT is_admin FROM profiles WHERE id = auth.uid())
  );

-- 5. Set a specific user as Admin (Optional: Replace with your actual ID later)
-- UPDATE profiles SET is_admin = TRUE WHERE id = 'YOUR_USER_ID_HERE';
