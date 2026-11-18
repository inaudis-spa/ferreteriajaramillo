SET NAMES utf8mb4;

INSERT INTO site_media_slots(slot_key,label,media_type,path) VALUES
('brand_logo','Logo de la web','image','ferreterialacustre/logo-circular-de-ferreteria-lacustre.webp'),
('hero_poster','Portada del video principal','image','ferreterialacustre/756620204_18117368666474540_4511804222887434583_n.jpg'),
('catalog_video','Video de cabecera del catalogo','video','ferreterialacustre/ferreteria-lacustre-mesa-magnetica-1.mp4')
ON DUPLICATE KEY UPDATE label=VALUES(label),media_type=VALUES(media_type);

INSERT INTO gallery_media(media_type,path,title,sort_order,is_published) SELECT 'image','ferreterialacustre/726860337_18112721510474540_6116532263735724105_n.jpg','Ideas y promociones Lacustre',10,1 WHERE NOT EXISTS (SELECT 1 FROM gallery_media WHERE path='ferreterialacustre/726860337_18112721510474540_6116532263735724105_n.jpg');
INSERT INTO gallery_media(media_type,path,title,sort_order,is_published) SELECT 'image','ferreterialacustre/746129811_18115650632474540_2184995197714707394_n.jpg','Novedades Ferreteria Lacustre',20,1 WHERE NOT EXISTS (SELECT 1 FROM gallery_media WHERE path='ferreterialacustre/746129811_18115650632474540_2184995197714707394_n.jpg');
INSERT INTO gallery_media(media_type,path,title,sort_order,is_published) SELECT 'image','ferreterialacustre/753604834_18117215912474540_128227561102007455_n.jpg','Consejos y oportunidades',30,1 WHERE NOT EXISTS (SELECT 1 FROM gallery_media WHERE path='ferreterialacustre/753604834_18117215912474540_128227561102007455_n.jpg');
