DROP TABLE IF EXISTS `vending_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vending_locations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vending_machine_id` int(10) unsigned DEFAULT NULL,
  `encoding` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vending_locations_unique_idx` (`id`,`encoding`),
  KEY `IDX_FB51EA3982EA3E1C` (`vending_machine_id`),
  CONSTRAINT `FK_FB51EA3982EA3E1C` FOREIGN KEY (`vending_machine_id`) REFERENCES `vending_machines` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

