CREATE TABLE IF NOT EXISTS `zones` (
  `zone_id` int(11) NOT NULL,
  `zone_description` varchar(100) NOT NULL,
  `zone_short_name` varchar(10) NOT NULL,
  `permission_code` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;