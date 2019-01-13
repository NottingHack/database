DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `generated` datetime NOT NULL DEFAULT current_timestamp(),
  `status` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_6A2F2F95A832C1C9` (`email_id`),
  KEY `IDX_6A2F2F95A76ED395` (`user_id`),
  CONSTRAINT `FK_6A2F2F95A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_6A2F2F95A832C1C9` FOREIGN KEY (`email_id`) REFERENCES `snackspace_emails` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

