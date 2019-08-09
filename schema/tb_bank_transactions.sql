DROP TABLE IF EXISTS `bank_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bank_transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bank_id` int(10) unsigned DEFAULT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` int(11) NOT NULL,
  `transaction_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `duplicate_idx` (`transaction_date`,`description`,`amount`),
  KEY `IDX_2A30FD5711C8FB41` (`bank_id`),
  KEY `IDX_2A30FD579B6B5FBA` (`account_id`),
  KEY `IDX_2A30FD572FC0CB0F` (`transaction_id`),
  CONSTRAINT `FK_2A30FD5711C8FB41` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`id`),
  CONSTRAINT `FK_2A30FD572FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`),
  CONSTRAINT `FK_2A30FD579B6B5FBA` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

