DROP TABLE IF EXISTS `temporary_access_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temporary_access_bookings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `color` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bookable_area_id` int(10) unsigned DEFAULT NULL,
  `guests` int(10) unsigned NOT NULL DEFAULT 0,
  `notes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approved` tinyint(1) NOT NULL DEFAULT 0,
  `approved_by_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DFC09B0BA76ED395` (`user_id`),
  KEY `IDX_DFC09B0BBD9A6AEE` (`bookable_area_id`),
  KEY `IDX_DFC09B0B2D234F6A` (`approved_by_id`),
  CONSTRAINT `FK_DFC09B0B2D234F6A` FOREIGN KEY (`approved_by_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_DFC09B0BA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_DFC09B0BBD9A6AEE` FOREIGN KEY (`bookable_area_id`) REFERENCES `bookable_areas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

