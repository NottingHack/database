DROP TABLE IF EXISTS `zone_occupants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zone_occupants` (
  `user_id` int(10) unsigned NOT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `time_entered` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`),
  KEY `IDX_EECE6E0B9F2C3FAB` (`zone_id`),
  CONSTRAINT `FK_EECE6E0B9F2C3FAB` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`id`),
  CONSTRAINT `FK_EECE6E0BA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

