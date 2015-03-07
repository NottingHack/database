CREATE TABLE IF NOT EXISTS `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `price` int(11) NOT NULL,
  `barcode` varchar(25) DEFAULT NULL,
  `available` int(11) DEFAULT NULL COMMENT '0=no, 1=yes',
  `shortdesc` varchar(25) DEFAULT NULL,
  `longdesc` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `product_barcode` (`barcode`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1