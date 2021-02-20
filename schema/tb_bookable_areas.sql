DROP TABLE IF EXISTS `bookable_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookable_areas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `building_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_occupancy` int(10) unsigned NOT NULL DEFAULT 1,
  `additional_guest_occupancy` int(10) unsigned NOT NULL DEFAULT 0,
  `booking_color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `self_bookable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CD8830944D2A7E12` (`building_id`),
  CONSTRAINT `FK_CD8830944D2A7E12` FOREIGN KEY (`building_id`) REFERENCES `buildings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

