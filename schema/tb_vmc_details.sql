CREATE TABLE IF NOT EXISTS `vmc_details` (
  `vmc_id` int(11) NOT NULL DEFAULT '0',
  `vmc_description` varchar(100) DEFAULT NULL,
  `vmc_type` varchar(10) DEFAULT NULL COMMENT 'VEND or NOTE',
  `vmc_connection` varchar(10) DEFAULT NULL COMMENT 'UDP or MQTT',
  `vmc_address` varchar(100) DEFAULT NULL COMMENT 'IP address:port or MQTT topic',
  PRIMARY KEY (`vmc_id`),
  UNIQUE KEY `vmc_ref_loc` (`vmc_connection`,`vmc_address`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1