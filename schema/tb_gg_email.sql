CREATE TABLE IF NOT EXISTS `gg_email` (
  `ggemail_id` int(11) NOT NULL AUTO_INCREMENT,
  `ggemail_subj` varchar(200) DEFAULT NULL,
  `ggemail_body` varchar(10000) DEFAULT NULL,
  `ggemail_body_wc` varchar(10000) DEFAULT NULL,
  `ggemail_from` varchar(200) DEFAULT NULL,
  `ggemail_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ggemail_reply_to` varchar(200) DEFAULT NULL,
  `ggemail_msg_id` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ggemail_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1