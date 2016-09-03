CREATE TABLE IF NOT EXISTS `light_level` (
  `name` varchar(100) DEFAULT NULL,
  `sensor` varchar(30) NOT NULL,
  `reading` int(11) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sensor`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1