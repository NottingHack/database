CREATE TABLE IF NOT EXISTS `tl_google` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identity` varchar(255) DEFAULT NULL COMMENT 'google account username',
  `refresh_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;