CREATE TABLE IF NOT EXISTS `gg_addresses` (
  `ggaddresses_id` int(11) NOT NULL AUTO_INCREMENT,
  `ggaddress_email` varchar(200) DEFAULT NULL,
  `ggaddress_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ggaddresses_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1