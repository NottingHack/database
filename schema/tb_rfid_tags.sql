DROP TABLE IF EXISTS `rfid_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rfid_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `rfid_serial` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rfid_serial_legacy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT 0,
  `last_used` datetime DEFAULT NULL,
  `friendly_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_5728019B27A4676` (`rfid_serial`),
  UNIQUE KEY `UNIQ_5728019BA12AD2E8` (`rfid_serial_legacy`),
  KEY `IDX_5728019BA76ED395` (`user_id`),
  CONSTRAINT `FK_5728019BA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

