DROP TABLE IF EXISTS `lighting_input_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lighting_input_channels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pattern_id` int(10) unsigned DEFAULT NULL,
  `controller_id` int(10) unsigned DEFAULT NULL,
  `channel` int(11) NOT NULL,
  `statefull` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `IDX_3A1926B7F734A20F` (`pattern_id`),
  KEY `IDX_3A1926B7F6D1A74B` (`controller_id`),
  CONSTRAINT `FK_3A1926B7F6D1A74B` FOREIGN KEY (`controller_id`) REFERENCES `lighting_controllers` (`id`),
  CONSTRAINT `FK_3A1926B7F734A20F` FOREIGN KEY (`pattern_id`) REFERENCES `lighting_patterns` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

