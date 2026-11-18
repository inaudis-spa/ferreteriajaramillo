USE ferreteria_lacustre;
SET NAMES utf8mb4;

-- Compatibilidad con instalaciones antiguas que importaron schema.sql sin catálogo.
-- Para instalaciones nuevas basta importar database/schema.sql.
INSERT IGNORE INTO products(id,category_id,name,slug,stock_mode,is_published,sort_order) VALUES
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

INSERT IGNORE INTO product_images(product_id,path,alt_text,is_cover) VALUES
(1,'ferreterialacustre/soldadora.jpg','Soldadora',1),(2,'ferreterialacustre/camara-inspeccion.jpg','Cámara de inspección',1),(3,'ferreterialacustre/disco-diamantado.jpg','Disco diamantado',1),(4,'ferreterialacustre/sierra-copa-wello.jpg','Sierra copa',1),(5,'ferreterialacustre/llave-pico-loro.jpg','Llave pico de loro',1),(6,'ferreterialacustre/tijera-podar.jpg','Tijera de podar',1),(7,'ferreterialacustre/escalera-8-peldanos.jpg','Escalera',1),(8,'ferreterialacustre/serruch-englete.jpg','Serrucho de inglete',1),(9,'ferreterialacustre/coplas-hope.jpg','Coplas HDPE',1),(10,'ferreterialacustre/tuberia-hope-3.jpg','Tubería HDPE',1),(11,'ferreterialacustre/terminal-compresion.jpg','Terminal de compresión',1),(12,'ferreterialacustre/t-de-pvc.jpg','Tee de PVC',1),(13,'ferreterialacustre/griferia-piazza.jpg','Grifería',1),(14,'ferreterialacustre/pintura-3-en-1.jpg','Pintura 3 en 1',1),(15,'ferreterialacustre/membrana-hidroguga.jpg','Membrana hidrófuga',1),(16,'ferreterialacustre/silicona-y-selladores.jpg','Siliconas y selladores',1),(17,'ferreterialacustre/tapagotera.jpg','Tapagotera',1),(18,'ferreterialacustre/bandeja-para-pintura.jpg','Bandeja para pintura',1),(19,'ferreterialacustre/zinc.jpg','Planchas de zinc',1),(20,'ferreterialacustre/malla-de-acero.jpg','Malla de acero',1),(21,'ferreterialacustre/alambre-pua.jpg','Alambre de púas',1),(22,'ferreterialacustre/clavo-techo-212.jpg','Clavo de techo',1),(23,'ferreterialacustre/horqueta.jpg','Horqueta',1),(24,'ferreterialacustre/rastrillo-de-fierro.jpg','Rastrillo de fierro',1);

UPDATE products SET is_published=1,is_featured=1 WHERE id IN (1,2,9,10,14,16,19,20);
UPDATE products SET is_published=1,is_offer=1 WHERE id IN (1,14,20);
