DROP TABLE IF EXISTS `lighting_output_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lighting_output_channels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `controller_id` int(10) unsigned DEFAULT NULL,
  `channel` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8F437396F6D1A74B` (`controller_id`),
  CONSTRAINT `FK_8F437396F6D1A74B` FOREIGN KEY (`controller_id`) REFERENCES `lighting_controllers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

