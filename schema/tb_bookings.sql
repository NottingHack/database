DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `tool_id` int(10) unsigned DEFAULT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7A853C35A76ED395` (`user_id`),
  KEY `IDX_7A853C358F7B22CC` (`tool_id`),
  CONSTRAINT `FK_7A853C358F7B22CC` FOREIGN KEY (`tool_id`) REFERENCES `tools` (`id`),
  CONSTRAINT `FK_7A853C35A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

