DROP TABLE IF EXISTS `zone_occupancy_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zone_occupancy_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `zone_id` int(11) DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `time_exited` datetime DEFAULT NULL,
  `time_entered` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_59ADE3689F2C3FAB` (`zone_id`),
  KEY `IDX_59ADE368A76ED395` (`user_id`),
  CONSTRAINT `FK_59ADE3689F2C3FAB` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`id`),
  CONSTRAINT `FK_59ADE368A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

