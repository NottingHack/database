DROP TABLE IF EXISTS `stripe_charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stripe_charges` (
  `id` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `transaction_id` int(10) unsigned DEFAULT NULL,
  `refund_transaction_id` int(10) unsigned DEFAULT NULL,
  `withdrawn_transaction_id` int(10) unsigned DEFAULT NULL,
  `reinstated_transaction_id` int(10) unsigned DEFAULT NULL,
  `payment_intent_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refund_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dispute_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_152861E02FC0CB0F` (`transaction_id`),
  KEY `IDX_152861E0A99A014E` (`refund_transaction_id`),
  KEY `IDX_152861E04484ADA4` (`withdrawn_transaction_id`),
  KEY `IDX_152861E0ED11AA78` (`reinstated_transaction_id`),
  KEY `IDX_152861E0A76ED395` (`user_id`),
  CONSTRAINT `FK_152861E02FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`),
  CONSTRAINT `FK_152861E04484ADA4` FOREIGN KEY (`withdrawn_transaction_id`) REFERENCES `transactions` (`id`),
  CONSTRAINT `FK_152861E0A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_152861E0A99A014E` FOREIGN KEY (`refund_transaction_id`) REFERENCES `transactions` (`id`),
  CONSTRAINT `FK_152861E0ED11AA78` FOREIGN KEY (`reinstated_transaction_id`) REFERENCES `transactions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

