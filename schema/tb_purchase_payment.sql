DROP TABLE IF EXISTS `purchase_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_payment` (
  `transaction_id_purchase` int(10) unsigned NOT NULL,
  `transaction_id_payment` int(10) unsigned NOT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`transaction_id_purchase`,`transaction_id_payment`),
  KEY `IDX_76F24E748D452883` (`transaction_id_purchase`),
  KEY `IDX_76F24E745C231ACC` (`transaction_id_payment`),
  CONSTRAINT `FK_76F24E745C231ACC` FOREIGN KEY (`transaction_id_payment`) REFERENCES `transactions` (`id`),
  CONSTRAINT `FK_76F24E748D452883` FOREIGN KEY (`transaction_id_purchase`) REFERENCES `transactions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

