DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile` (
  `user_id` int(10) unsigned NOT NULL,
  `join_date` datetime DEFAULT NULL,
  `unlock_text` varchar(95) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit_limit` int(10) unsigned NOT NULL DEFAULT 0,
  `address_1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_3` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_county` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_postcode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `balance` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `FK_8157AA0FA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

