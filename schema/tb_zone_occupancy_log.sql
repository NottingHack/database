CREATE TABLE IF NOT EXISTS `zone_occupancy_log` (
  `zone_occ_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `zone_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `time_exited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_entered` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`zone_occ_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;