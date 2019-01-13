CREATE TABLE IF NOT EXISTS `purchase_payment` (
  `transaction_id_purchase` int(11) NOT NULL DEFAULT '0',
  `transaction_id_payment` int(11) NOT NULL DEFAULT '0',
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`transaction_id_purchase`,`transaction_id_payment`),
  KEY `idx__purchase_payment__transaction_id_purchase` (`transaction_id_purchase`),
  KEY `idx__purchase_payment__transaction_id_payment` (`transaction_id_payment`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;