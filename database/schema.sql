CREATE DATABASE IF NOT EXISTS ferreteria_lacustre CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ferreteria_lacustre;
SET NAMES utf8mb4;
CREATE TABLE admin_users (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,email VARCHAR(190) NOT NULL UNIQUE,password_hash VARCHAR(255) NOT NULL,name VARCHAR(120) NOT NULL,is_active TINYINT(1) NOT NULL DEFAULT 1,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE categories (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,name VARCHAR(120) NOT NULL,slug VARCHAR(150) NOT NULL UNIQUE,description TEXT NULL,seo_title VARCHAR(190) NULL,seo_description VARCHAR(320) NULL,geo_content MEDIUMTEXT NULL,is_indexable TINYINT(1) NOT NULL DEFAULT 1,is_active TINYINT(1) NOT NULL DEFAULT 1,sort_order INT NOT NULL DEFAULT 0,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
CREATE TABLE products (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,category_id INT UNSIGNED NULL,name VARCHAR(190) NOT NULL,slug VARCHAR(190) NOT NULL UNIQUE,sku VARCHAR(100) NULL UNIQUE,brand VARCHAR(120) NULL,short_description TEXT NULL,long_description MEDIUMTEXT NULL,seo_title VARCHAR(190) NULL,seo_description VARCHAR(320) NULL,is_indexable TINYINT(1) NOT NULL DEFAULT 1,price DECIMAL(12,2) NULL,old_price DECIMAL(12,2) NULL,stock INT NULL,stock_mode ENUM('track','consult') NOT NULL DEFAULT 'consult',is_featured TINYINT(1) NOT NULL DEFAULT 0,is_offer TINYINT(1) NOT NULL DEFAULT 0,is_published TINYINT(1) NOT NULL DEFAULT 0,sort_order INT NOT NULL DEFAULT 0,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,CONSTRAINT fk_product_category FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE SET NULL);
CREATE TABLE product_images (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,product_id INT UNSIGNED NOT NULL,path VARCHAR(500) NOT NULL,alt_text VARCHAR(255) NULL,is_cover TINYINT(1) NOT NULL DEFAULT 0,sort_order INT NOT NULL DEFAULT 0,focal_x TINYINT UNSIGNED NOT NULL DEFAULT 50,focal_y TINYINT UNSIGNED NOT NULL DEFAULT 50,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,CONSTRAINT fk_image_product FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE);
CREATE TABLE gallery_media (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,media_type ENUM('image','video') NOT NULL,path VARCHAR(500) NOT NULL,title VARCHAR(190) NULL,description TEXT NULL,sort_order INT NOT NULL DEFAULT 0,is_published TINYINT(1) NOT NULL DEFAULT 0,focal_x TINYINT UNSIGNED NOT NULL DEFAULT 50,focal_y TINYINT UNSIGNED NOT NULL DEFAULT 50,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
CREATE TABLE site_media_slots (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,slot_key VARCHAR(80) NOT NULL UNIQUE,label VARCHAR(160) NOT NULL,media_type ENUM('image','video') NOT NULL,path VARCHAR(500) NOT NULL,focal_x TINYINT UNSIGNED NOT NULL DEFAULT 50,focal_y TINYINT UNSIGNED NOT NULL DEFAULT 50,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
CREATE TABLE site_media_history (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,slot_id INT UNSIGNED NOT NULL,path VARCHAR(500) NOT NULL,focal_x TINYINT UNSIGNED NOT NULL DEFAULT 50,focal_y TINYINT UNSIGNED NOT NULL DEFAULT 50,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,CONSTRAINT fk_history_slot FOREIGN KEY(slot_id) REFERENCES site_media_slots(id) ON DELETE CASCADE);
INSERT INTO categories(name,slug,sort_order) VALUES ('Herramientas','herramientas',10),('Fitting','fitting',20),('Pinturas','pinturas',30),('Construcción','construccion',40);
INSERT INTO site_media_slots(slot_key,label,media_type,path) VALUES
('brand_logo','Logo de la web','image','ferreterialacustre/logo-circular-de-ferreteria-lacustre.webp'),
('intro_video','Video de introducción','video','ferreterialacustre/ferreteria-lacustre-cargainicio.mp4'),
('hero_video','Video principal','video','ferreterialacustre/vitrina-herramienta-ferreteria.mp4'),
('hero_poster','Portada del video principal','image','ferreterialacustre/756620204_18117368666474540_4511804222887434583_n.jpg'),
('catalog_video','Video de cabecera del catalogo','video','ferreterialacustre/ferreteria-lacustre-mesa-magnetica-1.mp4'),
('offers_cover','Portada de ofertas','image','ferreterialacustre/744597669_18115633733474540_3242597299007188298_n.jpg');
INSERT INTO gallery_media(media_type,path,title,sort_order,is_published) VALUES
('image','ferreterialacustre/726860337_18112721510474540_6116532263735724105_n.jpg','Ideas y promociones Lacustre',10,1),
('image','ferreterialacustre/746129811_18115650632474540_2184995197714707394_n.jpg','Novedades Ferreteria Lacustre',20,1),
('image','ferreterialacustre/753604834_18117215912474540_128227561102007455_n.jpg','Consejos y oportunidades',30,1);

-- Catálogo inicial. Se incluye aquí para que una sola importación deje la web operativa.
INSERT INTO products(id,category_id,name,slug,stock_mode,is_published,sort_order) VALUES
(1,(SELECT id FROM categories WHERE slug='herramientas'),'Soldadora','soldadora','consult',1,10),
(2,(SELECT id FROM categories WHERE slug='herramientas'),'Cámara de inspección','camara-inspeccion','consult',1,20),
(3,(SELECT id FROM categories WHERE slug='herramientas'),'Disco diamantado','disco-diamantado','consult',1,30),
(4,(SELECT id FROM categories WHERE slug='herramientas'),'Sierra copa','sierra-copa','consult',1,40),
(5,(SELECT id FROM categories WHERE slug='herramientas'),'Llave pico de loro','llave-pico-loro','consult',1,50),
(6,(SELECT id FROM categories WHERE slug='herramientas'),'Tijera de podar','tijera-podar','consult',1,60),
(7,(SELECT id FROM categories WHERE slug='herramientas'),'Escalera 8 peldaños','escalera-8-peldanos','consult',1,70),
(8,(SELECT id FROM categories WHERE slug='herramientas'),'Serrucho de inglete','serrucho-inglete','consult',1,80),
(9,(SELECT id FROM categories WHERE slug='fitting'),'Coplas HDPE','coplas-hdpe','consult',1,90),
(10,(SELECT id FROM categories WHERE slug='fitting'),'Tubería HDPE','tuberia-hdpe','consult',1,100),
(11,(SELECT id FROM categories WHERE slug='fitting'),'Terminal de compresión','terminal-compresion','consult',1,110),
(12,(SELECT id FROM categories WHERE slug='fitting'),'Tee de PVC','tee-pvc','consult',1,120),
(13,(SELECT id FROM categories WHERE slug='fitting'),'Grifería Piazza','griferia-piazza','consult',1,130),
(14,(SELECT id FROM categories WHERE slug='pinturas'),'Pintura 3 en 1','pintura-3-en-1','consult',1,140),
(15,(SELECT id FROM categories WHERE slug='pinturas'),'Membrana hidrófuga','membrana-hidrofuga','consult',1,150),
(16,(SELECT id FROM categories WHERE slug='pinturas'),'Siliconas y selladores','siliconas-selladores','consult',1,160),
(17,(SELECT id FROM categories WHERE slug='pinturas'),'Tapagotera','tapagotera','consult',1,170),
(18,(SELECT id FROM categories WHERE slug='pinturas'),'Bandeja para pintura','bandeja-pintura','consult',1,180),
(19,(SELECT id FROM categories WHERE slug='construccion'),'Planchas de zinc','planchas-zinc','consult',1,190),
(20,(SELECT id FROM categories WHERE slug='construccion'),'Malla de acero','malla-acero','consult',1,200),
(21,(SELECT id FROM categories WHERE slug='construccion'),'Alambre de púas','alambre-puas','consult',1,210),
(22,(SELECT id FROM categories WHERE slug='construccion'),'Clavo de techo 2 ½','clavo-techo','consult',1,220),
(23,(SELECT id FROM categories WHERE slug='construccion'),'Horqueta','horqueta','consult',1,230),
(24,(SELECT id FROM categories WHERE slug='construccion'),'Rastrillo de fierro','rastrillo-fierro','consult',1,240);

INSERT INTO product_images(product_id,path,alt_text,is_cover) VALUES
(1,'ferreterialacustre/soldadora.jpg','Soldadora',1),(2,'ferreterialacustre/camara-inspeccion.jpg','Cámara de inspección',1),(3,'ferreterialacustre/disco-diamantado.jpg','Disco diamantado',1),(4,'ferreterialacustre/sierra-copa-wello.jpg','Sierra copa',1),(5,'ferreterialacustre/llave-pico-loro.jpg','Llave pico de loro',1),(6,'ferreterialacustre/tijera-podar.jpg','Tijera de podar',1),(7,'ferreterialacustre/escalera-8-peldanos.jpg','Escalera',1),(8,'ferreterialacustre/serruch-englete.jpg','Serrucho de inglete',1),(9,'ferreterialacustre/coplas-hope.jpg','Coplas HDPE',1),(10,'ferreterialacustre/tuberia-hope-3.jpg','Tubería HDPE',1),(11,'ferreterialacustre/terminal-compresion.jpg','Terminal de compresión',1),(12,'ferreterialacustre/t-de-pvc.jpg','Tee de PVC',1),(13,'ferreterialacustre/griferia-piazza.jpg','Grifería',1),(14,'ferreterialacustre/pintura-3-en-1.jpg','Pintura 3 en 1',1),(15,'ferreterialacustre/membrana-hidroguga.jpg','Membrana hidrófuga',1),(16,'ferreterialacustre/silicona-y-selladores.jpg','Siliconas y selladores',1),(17,'ferreterialacustre/tapagotera.jpg','Tapagotera',1),(18,'ferreterialacustre/bandeja-para-pintura.jpg','Bandeja para pintura',1),(19,'ferreterialacustre/zinc.jpg','Planchas de zinc',1),(20,'ferreterialacustre/malla-de-acero.jpg','Malla de acero',1),(21,'ferreterialacustre/alambre-pua.jpg','Alambre de púas',1),(22,'ferreterialacustre/clavo-techo-212.jpg','Clavo de techo',1),(23,'ferreterialacustre/horqueta.jpg','Horqueta',1),(24,'ferreterialacustre/rastrillo-de-fierro.jpg','Rastrillo de fierro',1);

UPDATE products SET is_featured=1 WHERE id IN (1,2,9,10,14,16,19,20);
UPDATE products SET is_offer=1 WHERE id IN (1,14,20);
