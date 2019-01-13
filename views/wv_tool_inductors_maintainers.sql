DROP VIEW IF EXISTS `wv_tool_inductors_maintainers`;

CREATE VIEW `wv_tool_inductors_maintainers` AS
SELECT
  `tl_tools`.`tool_id` AS `tool_id`,
  `tl_tools`.`tool_name` AS `tool_name`,
  `tl_members_tools`.`mt_access_level` AS `access_level`,
  CONCAT_WS(' ', `members`.`firstname`, `members`.`surname`) AS `member_name`,
  `status`.`title` AS `member_status`
FROM (((`tl_tools`
  JOIN `tl_members_tools` ON (`tl_tools`.`tool_id` = `tl_members_tools`.`tool_id`))
  JOIN `members` ON (`members`.`member_id` = `tl_members_tools`.`member_id`))
  JOIN `status` ON (`members`.`member_status` = `status`.`status_id`))
WHERE (`tl_members_tools`.`mt_access_level` IN ('INDUCTOR','MAINTAINER'))
ORDER BY
  `tl_tools`.`tool_id`,
  `tl_members_tools`.`mt_access_level`,
  CONCAT_WS(' ', `members`.`firstname`, `members`.`surname`);
