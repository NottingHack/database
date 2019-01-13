CREATE TABLE IF NOT EXISTS `zone_occupancy` (
  `zone_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `time_entered` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;