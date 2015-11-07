CREATE TABLE IF NOT EXISTS `bells` (
  `bell_id` int(11) NOT NULL,
  `bell_description` varchar(100) NOT NULL,
  `bell_topic` varchar(100) NOT NULL,
  `bell_message` varchar(50) NOT NULL,
  `bell_enabled` tinyint(1) NOT NULL DEFAULT '1',
  UNIQUE KEY `bell_id` (`bell_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;