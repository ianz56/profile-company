-- Add description and stock columns
ALTER TABLE products ADD COLUMN IF NOT EXISTS description TEXT;
ALTER TABLE products ADD COLUMN IF NOT EXISTS stock INTEGER DEFAULT 100;

-- Update existing products with generic descriptions
UPDATE products SET description = 'Bahan masakan segar pilihan terbaik dari SegarTani. Dipanen langsung dari petani lokal untuk menjaga kualitas dan kesegaran sampai ke tangan Anda. Kaya akan nutrisi dan vitamin yang dibutuhkan tubuh.' WHERE description IS NULL;

-- Example of specific update
UPDATE products SET description = 'Bayam hijau segar pilihan, kaya akan zat besi dan nutrisi penting. Cocok untuk masakan bening atau tumisan sehat keluarga.' WHERE name = 'Bayam Hijau Segar';
UPDATE products SET description = 'Wortel organik premium, renyah dan manis alami. Sangat baik untuk kesehatan mata dan diolah menjadi berbagai macam masakan.' WHERE name = 'Wortel Organik';
