-- Create the vouchers table
CREATE TABLE IF NOT EXISTS vouchers (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  code TEXT UNIQUE NOT NULL,
  discount_type TEXT NOT NULL CHECK (discount_type IN ('percentage', 'fixed')),
  discount_value NUMERIC NOT NULL,
  min_purchase NUMERIC DEFAULT 0,
  is_active BOOLEAN DEFAULT TRUE,
  expiry_date TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security (RLS)
ALTER TABLE vouchers ENABLE ROW LEVEL SECURITY;

-- Policies
-- 1. Public can check if a voucher is active
CREATE POLICY "Public can view active vouchers" ON vouchers
  FOR SELECT USING (is_active = TRUE AND (expiry_date IS NULL OR expiry_date > NOW()));

-- 2. Admins can manage all vouchers
CREATE POLICY "Admins can manage vouchers" ON vouchers
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = auth.uid() 
      AND profiles.is_admin = TRUE
    )
  );

-- Seed some vouchers for testing
INSERT INTO vouchers (code, discount_type, discount_value, min_purchase)
VALUES 
  ('SEGAR10', 'percentage', 10, 50000),
  ('DISKON20K', 'fixed', 20000, 100000),
  ('COBAHEMAT', 'percentage', 5, 0)
ON CONFLICT (code) DO NOTHING;
