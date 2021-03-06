DROP TABLE IF EXISTS `snackspace_debts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snackspace_debts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `audit_time` datetime NOT NULL,
  `total_debt` int(11) DEFAULT NULL,
  `current_debt` int(11) DEFAULT NULL,
  `ex_debt` int(11) DEFAULT NULL,
  `total_credit` int(11) DEFAULT NULL,
  `current_credit` int(11) DEFAULT NULL,
  `ex_credit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

