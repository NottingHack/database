CREATE TABLE IF NOT EXISTS `emails` (
  `email_id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) DEFAULT NULL,
  `email_to` varchar(200) DEFAULT NULL,
  `email_cc` varchar(200) DEFAULT NULL,
  `email_bcc` varchar(200) DEFAULT NULL,
  `email_subj` varchar(200) DEFAULT NULL,
  `email_body` text,
  `email_body_alt` text,
  `email_status` varchar(16) DEFAULT NULL COMMENT 'PENDING, SENT, FAILED, BOUNCED [, RECEIVED?]',
  `email_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `email_link` int(11) DEFAULT NULL COMMENT 'for recieved emails: original email_id',
  PRIMARY KEY (`email_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1