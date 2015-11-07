CREATE TABLE IF NOT EXISTS `tl_google_notifications` (
  `channel_id` varchar(64) NOT NULL DEFAULT '',
  `tool_id` int(10) unsigned DEFAULT NULL,
  `channel_token` varchar(256) DEFAULT NULL,
  `resource_id` varchar(256) DEFAULT NULL,
  `channel_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `channel_expiration` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`channel_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;