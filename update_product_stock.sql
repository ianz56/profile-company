-- Add stock column to products table
ALTER TABLE products ADD COLUMN IF NOT EXISTS stock INTEGER DEFAULT 10;

-- Update existing products to have some stock (e.g., 50) for testing
UPDATE products SET stock = 50 WHERE stock IS NULL OR stock = 10;

-- Function to decrease stock safely
CREATE OR REPLACE FUNCTION decrease_stock(p_id BIGINT, p_qty INT)
RETURNS VOID AS $$
BEGIN
  UPDATE products
  SET stock = stock - p_qty
  WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;
