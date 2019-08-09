DROP TABLE IF EXISTS `light_lighting_pattern`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `light_lighting_pattern` (
  `light_id` int(10) unsigned NOT NULL,
  `pattern_id` int(10) unsigned NOT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`light_id`,`pattern_id`),
  KEY `IDX_6AC3221B3DA64B2C` (`light_id`),
  KEY `IDX_6AC3221BF734A20F` (`pattern_id`),
  CONSTRAINT `FK_6AC3221B3DA64B2C` FOREIGN KEY (`light_id`) REFERENCES `lights` (`id`),
  CONSTRAINT `FK_6AC3221BF734A20F` FOREIGN KEY (`pattern_id`) REFERENCES `lighting_patterns` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

