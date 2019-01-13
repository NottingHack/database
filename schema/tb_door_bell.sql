DROP TABLE IF EXISTS `door_bell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `door_bell` (
  `door_id` int(10) unsigned NOT NULL,
  `bell_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`door_id`,`bell_id`),
  KEY `IDX_3D65815658639EAE` (`door_id`),
  KEY `IDX_3D6581566D4ED28E` (`bell_id`),
  CONSTRAINT `FK_3D65815658639EAE` FOREIGN KEY (`door_id`) REFERENCES `doors` (`id`),
  CONSTRAINT `FK_3D6581566D4ED28E` FOREIGN KEY (`bell_id`) REFERENCES `bells` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

