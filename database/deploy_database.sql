
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `seo_title` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_description` varchar(320) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `geo_content` mediumtext COLLATE utf8mb4_unicode_ci,
  `is_indexable` tinyint(1) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `gallery_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gallery_media` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `media_type` enum('image','video') COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_published` tinyint(1) NOT NULL DEFAULT '0',
  `focal_x` tinyint unsigned NOT NULL DEFAULT '50',
  `focal_y` tinyint unsigned NOT NULL DEFAULT '50',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `path` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alt_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_cover` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int NOT NULL DEFAULT '0',
  `focal_x` tinyint unsigned NOT NULL DEFAULT '50',
  `focal_y` tinyint unsigned NOT NULL DEFAULT '50',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_image_product` (`product_id`),
  CONSTRAINT `fk_image_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned DEFAULT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_description` text COLLATE utf8mb4_unicode_ci,
  `long_description` mediumtext COLLATE utf8mb4_unicode_ci,
  `seo_title` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_description` varchar(320) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_indexable` tinyint(1) NOT NULL DEFAULT '1',
  `price` decimal(12,2) DEFAULT NULL,
  `old_price` decimal(12,2) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `stock_mode` enum('track','consult') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'consult',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `is_offer` tinyint(1) NOT NULL DEFAULT '0',
  `is_published` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  UNIQUE KEY `sku` (`sku`),
  KEY `fk_product_category` (`category_id`),
  CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `site_media_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `site_media_history` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `slot_id` int unsigned NOT NULL,
  `path` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `focal_x` tinyint unsigned NOT NULL DEFAULT '50',
  `focal_y` tinyint unsigned NOT NULL DEFAULT '50',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_history_slot` (`slot_id`),
  CONSTRAINT `fk_history_slot` FOREIGN KEY (`slot_id`) REFERENCES `site_media_slots` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `site_media_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `site_media_slots` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `slot_key` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `media_type` enum('image','video') COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `focal_x` tinyint unsigned NOT NULL DEFAULT '50',
  `focal_y` tinyint unsigned NOT NULL DEFAULT '50',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slot_key` (`slot_key`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `seo_title`, `seo_description`, `geo_content`, `is_indexable`, `is_active`, `sort_order`, `created_at`, `updated_at`) VALUES (1,'Herramientas','herramientas',NULL,NULL,NULL,NULL,1,1,10,'2026-11-18 02:28:45','2026-11-18 02:28:45'),(2,'Fitting','fitting',NULL,NULL,NULL,NULL,1,1,20,'2026-11-18 02:28:45','2026-11-18 02:28:45'),(3,'Pinturas','pinturas',NULL,NULL,NULL,NULL,1,1,30,'2026-11-18 02:28:45','2026-11-18 02:28:45'),(4,'Construcción','construccion',NULL,NULL,NULL,NULL,1,1,40,'2026-11-18 02:28:45','2026-11-18 03:02:45');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `gallery_media` WRITE;
/*!40000 ALTER TABLE `gallery_media` DISABLE KEYS */;
INSERT INTO `gallery_media` (`id`, `media_type`, `path`, `title`, `description`, `sort_order`, `is_published`, `focal_x`, `focal_y`, `created_at`, `updated_at`) VALUES (1,'image','ferreterialacustre/726860337_18112721510474540_6116532263735724105_n.jpg','Ideas y promociones Lacustre',NULL,10,1,50,50,'2026-11-18 03:28:25','2026-11-18 03:28:25'),(2,'image','ferreterialacustre/746129811_18115650632474540_2184995197714707394_n.jpg','Novedades Ferreteria Lacustre',NULL,20,1,50,50,'2026-11-18 03:28:25','2026-11-18 03:29:01'),(3,'image','ferreterialacustre/753604834_18117215912474540_128227561102007455_n.jpg','Consejos y oportunidades',NULL,30,1,50,50,'2026-11-18 03:28:25','2026-11-18 03:28:25');
/*!40000 ALTER TABLE `gallery_media` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` (`id`, `product_id`, `path`, `alt_text`, `is_cover`, `sort_order`, `focal_x`, `focal_y`, `created_at`) VALUES (1,1,'ferreterialacustre/soldadora.jpg','Soldadora',1,0,50,50,'2026-11-18 02:28:46'),(2,2,'ferreterialacustre/camara-inspeccion.jpg','Cámara de inspección',1,0,50,50,'2026-11-18 02:28:46'),(3,3,'ferreterialacustre/disco-diamantado.jpg','Disco diamantado',1,0,50,50,'2026-11-18 02:28:46'),(4,4,'ferreterialacustre/sierra-copa-wello.jpg','Sierra copa',1,0,50,50,'2026-11-18 02:28:46'),(5,5,'ferreterialacustre/llave-pico-loro.jpg','Llave pico de loro',1,0,50,50,'2026-11-18 02:28:46'),(6,6,'ferreterialacustre/tijera-podar.jpg','Tijera de podar',1,0,50,50,'2026-11-18 02:28:46'),(7,7,'ferreterialacustre/escalera-8-peldanos.jpg','Escalera 8 peldaños',1,0,50,50,'2026-11-18 02:28:46'),(8,8,'ferreterialacustre/serruch-englete.jpg','Serrucho de inglete',1,0,50,50,'2026-11-18 02:28:46'),(9,9,'ferreterialacustre/coplas-hope.jpg','Coplas HDPE',1,0,50,50,'2026-11-18 02:28:46'),(10,10,'ferreterialacustre/tuberia-hope-3.jpg','Tubería HDPE',1,0,50,50,'2026-11-18 02:28:46'),(11,11,'ferreterialacustre/terminal-compresion.jpg','Terminal de compresión',1,0,50,50,'2026-11-18 02:28:46'),(12,12,'ferreterialacustre/t-de-pvc.jpg','Tee de PVC',1,0,50,50,'2026-11-18 02:28:46'),(13,13,'ferreterialacustre/griferia-piazza.jpg','Grifería Piazza',1,0,50,50,'2026-11-18 02:28:46'),(14,14,'ferreterialacustre/pintura-3-en-1.jpg','Pintura 3 en 1',1,0,50,50,'2026-11-18 02:28:46'),(15,15,'ferreterialacustre/membrana-hidroguga.jpg','Membrana hidrófuga',1,0,50,50,'2026-11-18 02:28:46'),(16,16,'ferreterialacustre/silicona-y-selladores.jpg','Siliconas y selladores',1,0,50,50,'2026-11-18 02:28:46'),(17,17,'ferreterialacustre/tapagotera.jpg','Tapagotera',1,0,50,50,'2026-11-18 02:28:46'),(18,18,'ferreterialacustre/bandeja-para-pintura.jpg','Bandeja para pintura',1,0,50,50,'2026-11-18 02:28:46'),(19,19,'ferreterialacustre/zinc.jpg','Planchas de zinc',1,0,50,50,'2026-11-18 02:28:46'),(20,20,'ferreterialacustre/malla-de-acero.jpg','Malla de acero',1,0,50,50,'2026-11-18 02:28:46'),(21,21,'ferreterialacustre/alambre-pua.jpg','Alambre de púas',1,0,50,50,'2026-11-18 02:28:46'),(22,22,'ferreterialacustre/clavo-techo-212.jpg','Clavo de techo 2 ½”',1,0,50,50,'2026-11-18 02:28:46'),(23,23,'ferreterialacustre/horqueta.jpg','Horqueta',1,0,50,50,'2026-11-18 02:28:46'),(24,24,'ferreterialacustre/rastrillo-de-fierro.jpg','Rastrillo de fierro',1,0,50,50,'2026-11-18 02:28:46');
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `category_id`, `name`, `slug`, `sku`, `brand`, `short_description`, `long_description`, `seo_title`, `seo_description`, `is_indexable`, `price`, `old_price`, `stock`, `stock_mode`, `is_featured`, `is_offer`, `is_published`, `sort_order`, `created_at`, `updated_at`) VALUES (1,1,'Soldadora','soldadora',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',1,1,1,10,'2026-11-18 02:28:45','2026-11-18 12:42:54'),(2,1,'Cámara de inspección','camara-inspeccion',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',1,0,0,20,'2026-11-18 02:28:45','2026-11-18 04:04:04'),(3,1,'Disco diamantado','disco-diamantado',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,1,30,'2026-11-18 02:28:45','2026-11-18 02:28:45'),(4,1,'Sierra copa','sierra-copa',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,1,40,'2026-11-18 02:28:45','2026-11-18 02:28:45'),(5,1,'Llave pico de loro','llave-pico-loro',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,1,50,'2026-11-18 02:28:45','2026-11-18 02:28:45'),(6,1,'Tijera de podar','tijera-podar',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,1,60,'2026-11-18 02:28:45','2026-11-18 02:28:45'),(7,1,'Escalera 8 peldaños','escalera-8-peldanos',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,0,70,'2026-11-18 02:28:45','2026-11-18 04:08:43'),(8,1,'Serrucho de inglete','serrucho-inglete',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,1,80,'2026-11-18 02:28:45','2026-11-18 02:28:45'),(9,2,'Coplas HDPE','coplas-hdpe',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',1,0,1,90,'2026-11-18 02:28:45','2026-11-18 02:28:46'),(10,2,'Tubería HDPE','tuberia-hdpe',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',1,0,0,100,'2026-11-18 02:28:45','2026-11-18 04:08:46'),(11,2,'Terminal de compresión','terminal-compresion',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,1,110,'2026-11-18 02:28:45','2026-11-18 03:02:45'),(12,2,'Tee de PVC','tee-pvc',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,1,120,'2026-11-18 02:28:45','2026-11-18 02:28:45'),(13,2,'Grifería Piazza','griferia-piazza',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,1,130,'2026-11-18 02:28:45','2026-11-18 03:02:45'),(14,3,'Pintura 3 en 1','pintura-3-en-1',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',1,1,1,140,'2026-11-18 02:28:45','2026-11-18 12:42:54'),(15,3,'Membrana hidrófuga','membrana-hidrofuga',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,1,150,'2026-11-18 02:28:45','2026-11-18 03:02:45'),(16,3,'Siliconas y selladores','siliconas-selladores',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',1,0,1,160,'2026-11-18 02:28:45','2026-11-18 02:28:46'),(17,3,'Tapagotera','tapagotera',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,1,170,'2026-11-18 02:28:45','2026-11-18 02:28:45'),(18,3,'Bandeja para pintura','bandeja-pintura',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,1,180,'2026-11-18 02:28:45','2026-11-18 02:28:45'),(19,4,'Planchas de zinc','planchas-zinc',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',1,0,1,190,'2026-11-18 02:28:45','2026-11-18 02:28:46'),(20,4,'Malla de acero','malla-acero',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',1,1,1,200,'2026-11-18 02:28:45','2026-11-18 12:42:54'),(21,4,'Alambre de púas','alambre-puas',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,1,210,'2026-11-18 02:28:45','2026-11-18 03:02:45'),(22,4,'Clavo de techo 2 ½”','clavo-techo',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,1,220,'2026-11-18 02:28:45','2026-11-18 03:02:45'),(23,4,'Horqueta','horqueta',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,1,230,'2026-11-18 02:28:45','2026-11-18 02:28:45'),(24,4,'Rastrillo de fierro','rastrillo-fierro',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'consult',0,0,1,240,'2026-11-18 02:28:45','2026-11-18 02:28:45');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `site_media_slots` WRITE;
/*!40000 ALTER TABLE `site_media_slots` DISABLE KEYS */;
INSERT INTO `site_media_slots` (`id`, `slot_key`, `label`, `media_type`, `path`, `focal_x`, `focal_y`, `updated_at`) VALUES (1,'intro_video','Video de introducción','video','ferreterialacustre/ferreteria-lacustre-cargainicio.mp4',50,50,'2026-11-18 03:02:45'),(2,'hero_video','Video principal','video','ferreterialacustre/vitrina-herramienta-ferreteria.mp4',50,50,'2026-11-18 02:28:45'),(3,'offers_cover','Portada de ofertas','image','ferreterialacustre/744597669_18115633733474540_3242597299007188298_n.jpg',50,50,'2026-11-18 02:28:45'),(4,'brand_logo','Logo de la web','image','ferreterialacustre/logo-circular-de-ferreteria-lacustre.webp',50,50,'2026-11-18 12:37:10'),(5,'hero_poster','Portada del video principal','image','ferreterialacustre/756620204_18117368666474540_4511804222887434583_n.jpg',50,50,'2026-11-18 03:28:25'),(6,'catalog_video','Video de cabecera del catalogo','video','ferreterialacustre/ferreteria-lacustre-mesa-magnetica-1.mp4',50,50,'2026-11-18 04:15:29');
/*!40000 ALTER TABLE `site_media_slots` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

