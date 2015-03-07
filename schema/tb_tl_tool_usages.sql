CREATE TABLE IF NOT EXISTS `tl_tool_usages` (
  `usage_id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) DEFAULT NULL,
  `tool_id` int(11) DEFAULT NULL,
  `usage_start` datetime DEFAULT NULL COMMENT 'sign on time',
  `usage_duration` int(11) DEFAULT NULL COMMENT 'use duration, seconds',
  `usage_active_time` int(11) DEFAULT NULL COMMENT 'amount of time tool active for, where applicable (e.g. laser tube time)',
  `usage_status` varchar(20) DEFAULT NULL COMMENT 'IN_PROGRESS, COMPLETE or CHARGED',
  PRIMARY KEY (`usage_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;