/*
  # Add Middle Eastern products

  1. Changes
    - Inserts initial product catalog with Middle Eastern foods and ingredients
    - Each product includes name, description, price, and category
    - Categories: Spices, Pantry, Dairy, Bread, Meat, Sweets, Beverages

  2. Notes
    - Prices are set based on typical market rates
    - All products are marked as active (deleted_at is NULL)
*/

INSERT INTO products (name, description, price, category, image, created_at, updated_at) VALUES
-- Spices & Seasonings
('Za''atar', 'Traditional Middle Eastern spice blend with thyme, sesame seeds, and sumac', 6.99, 'Spices', 'https://images.pexels.com/photos/4198943/pexels-photo-4198943.jpeg', NOW(), NOW()),
('Sumac', 'Tangy, burgundy-colored ground spice essential in Middle Eastern cuisine', 7.99, 'Spices', 'https://images.pexels.com/photos/4198943/pexels-photo-4198943.jpeg', NOW(), NOW()),
('Shawarma Seasoning', 'Aromatic spice blend for perfect shawarma', 8.99, 'Spices', 'https://images.pexels.com/photos/4198943/pexels-photo-4198943.jpeg', NOW(), NOW()),

-- Pantry Items
('Tahini', 'Premium ground sesame paste', 9.99, 'Pantry', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Halawa', 'Sweet confection made from tahini', 12.99, 'Pantry', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Molokhia', 'Dried jute leaves for traditional soup', 5.99, 'Pantry', 'https://images.pexels.com/photos/3338497/pexels-photo-3338497.jpeg', NOW(), NOW()),
('Grape Leaves', 'Preserved vine leaves for dolmas', 6.99, 'Pantry', 'https://images.pexels.com/photos/3338497/pexels-photo-3338497.jpeg', NOW(), NOW()),
('Olive Oil', 'Extra virgin Palestinian olive oil', 19.99, 'Pantry', 'https://images.pexels.com/photos/33783/olive-oil-salad-dressing-cooking-olive.jpg', NOW(), NOW()),
('Ghee', 'Clarified butter', 14.99, 'Pantry', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Pomegranate Molasses', 'Sweet-tart syrup reduction', 8.99, 'Pantry', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Falafel Mix', 'Ready-to-prepare falafel mixture', 5.99, 'Pantry', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Harissa Paste', 'Spicy chili pepper paste', 7.99, 'Pantry', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Rose Water', 'Fragrant rose water for desserts', 6.99, 'Pantry', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Orange Blossom Water', 'Aromatic orange blossom water', 6.99, 'Pantry', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Black Seed Oil', 'Traditional healing oil', 16.99, 'Pantry', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),

-- Dairy Products
('Pickled Turnips', 'Crunchy pink pickled turnips', 4.99, 'Dairy', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Labneh', 'Strained yogurt cheese', 5.99, 'Dairy', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Halloumi Cheese', 'Grilling cheese from Cyprus', 8.99, 'Dairy', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Feta Cheese', 'Traditional Mediterranean cheese', 7.99, 'Dairy', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),

-- Breads
('Pita Bread', 'Fresh pocket bread', 3.99, 'Bread', 'https://images.pexels.com/photos/461060/pexels-photo-461060.jpeg', NOW(), NOW()),
('Markouk Bread', 'Paper-thin mountain bread', 4.99, 'Bread', 'https://images.pexels.com/photos/461060/pexels-photo-461060.jpeg', NOW(), NOW()),
('Lavash Bread', 'Soft, thin flatbread', 4.99, 'Bread', 'https://images.pexels.com/photos/461060/pexels-photo-461060.jpeg', NOW(), NOW()),
('Saj Bread', 'Traditional dome-baked flatbread', 4.99, 'Bread', 'https://images.pexels.com/photos/461060/pexels-photo-461060.jpeg', NOW(), NOW()),

-- Meats
('Fresh Lamb', 'Premium quality halal lamb', 15.99, 'Meat', 'https://images.pexels.com/photos/6287295/pexels-photo-6287295.jpeg', NOW(), NOW()),
('Halal Beef', 'Fresh halal beef cuts', 13.99, 'Meat', 'https://images.pexels.com/photos/6287295/pexels-photo-6287295.jpeg', NOW(), NOW()),
('Chicken Shawarma', 'Marinated chicken for shawarma', 11.99, 'Meat', 'https://images.pexels.com/photos/6941026/pexels-photo-6941026.jpeg', NOW(), NOW()),
('Merguez Sausage', 'Spicy lamb sausage', 9.99, 'Meat', 'https://images.pexels.com/photos/6287295/pexels-photo-6287295.jpeg', NOW(), NOW()),
('Kibbeh', 'Ready-to-cook meat and bulgur shells', 12.99, 'Meat', 'https://images.pexels.com/photos/6287295/pexels-photo-6287295.jpeg', NOW(), NOW()),

-- Sweets & Pastries
('Baklava', 'Layered phyllo pastry with nuts', 14.99, 'Sweets', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Maamoul', 'Date-filled semolina cookies', 12.99, 'Sweets', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Kunafa', 'Sweet cheese pastry in syrup', 16.99, 'Sweets', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),

-- Dry Goods
('Fresh Dates', 'Premium Medjool dates', 9.99, 'Dry Goods', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Dried Figs', 'Sweet dried figs', 7.99, 'Dry Goods', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Roasted Nuts', 'Mixed nuts selection', 11.99, 'Dry Goods', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Sesame Seeds', 'Raw sesame seeds', 4.99, 'Dry Goods', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Lentils', 'Premium red lentils', 5.99, 'Dry Goods', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Chickpeas', 'Dried chickpeas', 4.99, 'Dry Goods', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Bulgur', 'Cracked wheat', 4.99, 'Dry Goods', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Freekeh', 'Smoked green wheat', 6.99, 'Dry Goods', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Basmati Rice', 'Aromatic long-grain rice', 8.99, 'Dry Goods', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),
('Vermicelli Noodles', 'Fine wheat noodles', 3.99, 'Dry Goods', 'https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg', NOW(), NOW()),

-- Beverages
('Arabic Coffee', 'Traditional Arabic coffee blend', 12.99, 'Beverages', 'https://images.pexels.com/photos/894695/pexels-photo-894695.jpeg', NOW(), NOW()),
('Turkish Coffee', 'Fine-ground Turkish coffee', 11.99, 'Beverages', 'https://images.pexels.com/photos/894695/pexels-photo-894695.jpeg', NOW(), NOW());