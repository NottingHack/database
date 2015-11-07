CREATE TABLE IF NOT EXISTS `door_bells` (
  `door_id` int(11) NOT NULL,
  `bell_id` int(11) NOT NULL,
  UNIQUE KEY `door_id` (`door_id`,`bell_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;