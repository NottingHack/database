DROP TABLE IF EXISTS `access_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `door_id` int(10) unsigned DEFAULT NULL,
  `entered_zone_id` int(11) DEFAULT NULL,
  `access_time` datetime NOT NULL,
  `rfid_serial` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pin` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `access_result` int(11) NOT NULL DEFAULT 0,
  `denied_reason` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_656A05AA76ED395` (`user_id`),
  KEY `IDX_656A05A58639EAE` (`door_id`),
  KEY `access_time_index` (`access_time`),
  KEY `IDX_656A05A35D9DA3D` (`entered_zone_id`),
  CONSTRAINT `FK_656A05A35D9DA3D` FOREIGN KEY (`entered_zone_id`) REFERENCES `zones` (`id`),
  CONSTRAINT `FK_656A05A58639EAE` FOREIGN KEY (`door_id`) REFERENCES `doors` (`id`),
  CONSTRAINT `FK_656A05AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

