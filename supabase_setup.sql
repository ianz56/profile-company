-- Create the products table
CREATE TABLE products (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  price NUMERIC NOT NULL,
  discount NUMERIC DEFAULT 0,
  rating NUMERIC DEFAULT 5,
  image TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security (RLS)
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- Create a policy that allows anyone to read products
CREATE POLICY "Allow public read access" ON products
  FOR SELECT USING (true);

-- Seed data
INSERT INTO products (name, category, price, discount, rating, image)
VALUES 
  ('Bayam Hijau Segar', 'Sayuran', 5000, 0, 4.8, 'https://image.astronauts.cloud/product-images/2025/5/1Cover6_c8dc0d4f-3883-47c7-8a5d-a528cc767576_900x900.png'),
  ('Wortel Organik', 'Sayuran', 12000, 10, 4.7, 'https://image.astronauts.cloud/product-images/2026/2/Wortel2_e84e65b4-7b9d-4e8f-aa1d-8f4b79c9556d_900x900.jpg'),
  ('Brokoli Premium', 'Sayuran', 18000, 5, 4.9, 'https://image.astronauts.cloud/product-images/2024/11/1Cover1509dc8276ad894d9a9bb69dead8712275900x900_421814ec-b39e-40ca-8761-e60c9075186c_900x900.png'),
  ('Kentang Dieng', 'Sayuran', 15000, 0, 4.6, 'https://image.astronauts.cloud/product-images/2024/5/1Cover12_923a9c26-62a8-44cf-82b9-11ddee85b330_900x900.png'),
  ('Apel Fuji Manis', 'Buah', 35000, 15, 4.9, 'https://image.astronauts.cloud/product-images/2024/5/1CoverApelFujiEnvyPremium_ba07531f-71cb-4cd2-b6a7-a30b8869c932_900x900.png'),
  ('Jeruk Sunkist', 'Buah', 28000, 0, 4.7, 'https://image.astronauts.cloud/product-images/2024/7/1Cover_e0f99659-92d9-454e-9815-92b0961c4902_900x900.png'),
  ('Pisang Cavendish', 'Buah', 20000, 0, 4.8, 'https://image.astronauts.cloud/product-images/2025/10/PisangCavendish3_f3285ad7-0b8e-4b0a-ba71-77bc9442dccb_900x900.jpg'),
  ('Mangga Harum Manis', 'Buah', 25000, 10, 4.9, 'https://image.astronauts.cloud/product-images/2024/6/Cover212_8c6bbfd8-6cc7-494f-bc4f-5799569dc167_900x900.png'),
  ('Daging Sapi Sirloin', 'Daging', 145000, 5, 4.9, 'https://image.astronauts.cloud/product-images/2024/6/1Cover_38a78651-9a82-4b63-b185-98b17e7c510b_900x900.png'),
  ('Ayam Kampung Utuh', 'Daging', 85000, 0, 4.7, 'https://image.astronauts.cloud/product-images/2024/12/ayamutuh_ae270fca-101e-48bb-9db2-d4669b4a2fd5_700x697.jpg'),
  ('Telur Ayam Negeri (1kg)', 'Daging', 28000, 0, 4.6, 'https://image.astronauts.cloud/product-images/2024/10/telur15pcs_9c2d284a-ad27-496e-b43a-522eed5a0d57_900x900.jpg'),
  ('Ikan Gurame Segar', 'Daging', 45000, 10, 4.8, 'https://image.astronauts.cloud/product-images/2024/1/gurame_b3af22e0-8b6d-4cd7-9763-dcfa4e31d55f_900x900.jpg'),
  ('Bawang Merah', 'Bumbu Masak', 32000, 0, 4.6, 'https://image.astronauts.cloud/product-images/2024/5/1Cover48_c11abbc8-ed8b-4bc3-b955-f383e49883c8_900x900.png'),
  ('Bawang Putih', 'Bumbu Masak', 30000, 0, 4.5, 'https://down-id.img.susercontent.com/file/eaf0edba07a24a79e3de6b668a39aaf3'),
  ('Cabai Merah Keriting', 'Bumbu Masak', 45000, 20, 4.7, 'https://image.astronauts.cloud/product-images/2024/5/1CoverCabeMerahKeriting_64c962aa-74c6-4242-a0d9-a4800850560c_900x900.png'),
  ('Jahe', 'Bumbu Masak', 22000, 0, 4.6, 'https://image.astronauts.cloud/product-images/2024/5/1Cover_ded25d79-1793-43d8-a703-a8595ac4b3a5_900x900.jpg'),
  ('Kunyit', 'Bumbu Masak', 15000, 0, 4.5, 'https://desagrogol.gunungkidulkab.go.id/assets/files/artikel/sedang_1724401291KUNYIT.jpg'),
  ('Lengkuas', 'Bumbu Masak', 12000, 0, 4.7, 'https://image.astronauts.cloud/product-images/2025/4/1Cover620f070ad9e4d441239ff305bad8ca1036900x900_915c9b4e-ebaf-48fb-86c8-15b5670d27fa_900x900.png'),
  ('Tomat Merah', 'Sayuran', 10000, 5, 4.7, 'https://image.astronauts.cloud/product-images/2024/5/1Cover70_440135bb-63c8-43d8-b2ca-b4f2cbfdecf6_900x900.png'),
  ('Semangka', 'Buah', 30000, 0, 4.9, 'https://image.astronauts.cloud/product-images/2025/12/semangkamerah1e2d514cbb12a4c29a3aae53d852f4171900x900_70acf90d-4f7b-48f6-86ce-736ae6b4e284_900x900.jpg');
