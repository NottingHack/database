DROP TABLE IF EXISTS `product_vending_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_vending_location` (
  `vending_location_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`vending_location_id`,`product_id`),
  KEY `IDX_44048F6C035A559` (`vending_location_id`),
  KEY `IDX_44048F64584665A` (`product_id`),
  CONSTRAINT `FK_44048F64584665A` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_44048F6C035A559` FOREIGN KEY (`vending_location_id`) REFERENCES `vending_locations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

