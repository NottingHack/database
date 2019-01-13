CREATE TABLE IF NOT EXISTS `rfid_tags` (
  `rfid_id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `rfid_serial` varchar(50) DEFAULT NULL,
  `rfid_serial_legacy` varchar(50) DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT '0',
  `last_used` timestamp NULL DEFAULT NULL,
  `friendly_name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`rfid_id`),
  UNIQUE KEY (`rfid_serial`),
  UNIQUE KEY(`rfid_serial_legacy`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;