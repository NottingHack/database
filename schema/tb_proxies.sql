DROP TABLE IF EXISTS `proxies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meeting_id` int(10) unsigned DEFAULT NULL,
  `principal_id` int(10) unsigned DEFAULT NULL,
  `proxy_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `duplicate_principal_idx` (`meeting_id`,`principal_id`),
  KEY `IDX_148784BB67433D9C` (`meeting_id`),
  KEY `IDX_148784BB474870EE` (`principal_id`),
  KEY `IDX_148784BBDB26A4E` (`proxy_id`),
  CONSTRAINT `FK_148784BB474870EE` FOREIGN KEY (`principal_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_148784BB67433D9C` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`),
  CONSTRAINT `FK_148784BBDB26A4E` FOREIGN KEY (`proxy_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

