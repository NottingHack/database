CREATE TABLE IF NOT EXISTS `tl_tools` (
  `tool_id` int(11) NOT NULL AUTO_INCREMENT,
  `tool_address` varchar(255) DEFAULT NULL,
  `tool_name` varchar(20) DEFAULT NULL,
  `tool_status` varchar(20) DEFAULT NULL COMMENT 'IN_USE, FREE or DISABLED',
  `tool_restrictions` varchar(20) DEFAULT NULL COMMENT 'UNRESTRICTED or RESTRICTED',
  `tool_status_text` varchar(255) DEFAULT NULL COMMENT 'if tool_status=DISABLED, holds the reason why (free text)',
  `tool_pph` int(10) unsigned DEFAULT NULL COMMENT 'cost - pence per hour',
  `tool_booking_length` int(10) unsigned DEFAULT NULL COMMENT 'default booking length for this tool, minutes',
  `tool_length_max` int(10) unsigned DEFAULT NULL COMMENT 'maximum amount of time a booking can be made for, minutes',
  `tool_bookings_max` int(10) unsigned DEFAULT NULL COMMENT 'maximum number of bookings a user can have at any one time',
  `tool_calendar` varchar(255) DEFAULT NULL COMMENT 'id of google calendar',
  `tool_cal_poll_ival` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tool_id`),
  UNIQUE KEY `tool_name` (`tool_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;