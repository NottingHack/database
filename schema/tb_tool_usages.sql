DROP TABLE IF EXISTS `tool_usages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tool_usages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `tool_id` int(10) unsigned DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `active_time` int(11) DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2E8A5975A76ED395` (`user_id`),
  KEY `IDX_2E8A59758F7B22CC` (`tool_id`),
  CONSTRAINT `FK_2E8A59758F7B22CC` FOREIGN KEY (`tool_id`) REFERENCES `tools` (`id`),
  CONSTRAINT `FK_2E8A5975A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

