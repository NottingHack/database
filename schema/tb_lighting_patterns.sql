DROP TABLE IF EXISTS `lighting_patterns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lighting_patterns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `next_pattern_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `timeout` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8AD8F8FF48A349CC` (`next_pattern_id`),
  CONSTRAINT `FK_8AD8F8FF48A349CC` FOREIGN KEY (`next_pattern_id`) REFERENCES `lighting_patterns` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

