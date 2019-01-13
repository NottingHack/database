DROP TABLE IF EXISTS `vend_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vend_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vending_machine_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `transaction_id` int(10) unsigned DEFAULT NULL,
  `rfid_serial` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enqueued_time` datetime DEFAULT NULL,
  `request_time` datetime DEFAULT NULL,
  `success_time` datetime DEFAULT NULL,
  `cancelled_time` datetime DEFAULT NULL,
  `failed_time` datetime DEFAULT NULL,
  `amount_scaled` int(11) DEFAULT NULL,
  `position` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `denied_reason` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DEDF3B8082EA3E1C` (`vending_machine_id`),
  KEY `IDX_DEDF3B80A76ED395` (`user_id`),
  KEY `IDX_DEDF3B802FC0CB0F` (`transaction_id`),
  CONSTRAINT `FK_DEDF3B802FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`),
  CONSTRAINT `FK_DEDF3B8082EA3E1C` FOREIGN KEY (`vending_machine_id`) REFERENCES `vending_machines` (`id`),
  CONSTRAINT `FK_DEDF3B80A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

