DROP TABLE IF EXISTS `role_updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_updates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `added_role_id` int(10) unsigned DEFAULT NULL,
  `removed_role_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F985B6CBA76ED395` (`user_id`),
  KEY `IDX_F985B6CBE660F4B0` (`added_role_id`),
  KEY `IDX_F985B6CB85D15B53` (`removed_role_id`),
  CONSTRAINT `FK_6123F82085D15B53` FOREIGN KEY (`removed_role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `FK_6123F820A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_6123F820E660F4B0` FOREIGN KEY (`added_role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

