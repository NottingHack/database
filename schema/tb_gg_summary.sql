CREATE TABLE IF NOT EXISTS `gg_summary` (
  `ggemail_id` int(11) NOT NULL,
  `ggaddresses_id` int(11) NOT NULL,
  `ggsum_auto_wc` int(11) DEFAULT NULL,
  `ggsum_manual_wc` int(11) DEFAULT NULL,
  `ggemail_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ggemail_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1