DROP TABLE IF EXISTS `lights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lights` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `output_channel_id` int(10) unsigned DEFAULT NULL,
  `room_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_38BCB2E8455662C1` (`output_channel_id`),
  KEY `IDX_38BCB2E854177093` (`room_id`),
  CONSTRAINT `FK_38BCB2E8455662C1` FOREIGN KEY (`output_channel_id`) REFERENCES `lighting_output_channels` (`id`),
  CONSTRAINT `FK_38BCB2E854177093` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

