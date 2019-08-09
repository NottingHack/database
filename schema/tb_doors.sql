DROP TABLE IF EXISTS `doors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `side_a_zone_id` int(11) DEFAULT NULL,
  `side_b_zone_id` int(11) DEFAULT NULL,
  `description` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_change` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5E5B762A49451B7F` (`side_a_zone_id`),
  KEY `IDX_5E5B762A70C827BA` (`side_b_zone_id`),
  CONSTRAINT `FK_5E5B762A49451B7F` FOREIGN KEY (`side_a_zone_id`) REFERENCES `zones` (`id`),
  CONSTRAINT `FK_5E5B762A70C827BA` FOREIGN KEY (`side_b_zone_id`) REFERENCES `zones` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

