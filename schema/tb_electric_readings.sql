DROP TABLE IF EXISTS `electric_readings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `electric_readings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meter_id` int(10) unsigned DEFAULT NULL,
  `reading` int(11) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_206AAE626E15CA9E` (`meter_id`),
  CONSTRAINT `FK_206AAE626E15CA9E` FOREIGN KEY (`meter_id`) REFERENCES `electric_meters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

