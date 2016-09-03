CREATE TABLE IF NOT EXISTS `tl_members_tools` (
  `member_tool_id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) DEFAULT NULL,
  `tool_id` int(11) DEFAULT NULL,
  `member_id_induct` int(11) DEFAULT NULL COMMENT 'member_id of inductor',
  `mt_date_inducted` datetime DEFAULT NULL,
  `mt_access_level` varchar(20) DEFAULT NULL COMMENT 'USER, INDUCTOR or MAINTAINER',
  PRIMARY KEY (`member_tool_id`),
  UNIQUE KEY `tool_id` (`tool_id`,`member_id`)
) ENGINE=InnoDB CHARSET=latin1;