DROP VIEW IF EXISTS `wv_tool_users`;

CREATE VIEW `wv_tool_users`AS
SELECT
  `tl_tools`.`tool_id` AS `tool_id`,
  `tl_tools`.`tool_name` AS `tool_name`,
  `tl_members_tools`.`mt_access_level` AS `access_level`,
  SUM( IF(`tl_tool_usages`.`tool_id` = `tl_tools`.`tool_id`, 1, 0) ) AS `session_count`,
  ROUND( (SUM( IF(`tl_tool_usages`.`tool_id` = `tl_tools`.`tool_id`, IF(`tl_tool_usages`.`usage_duration` > 0, `tl_tool_usages`.`usage_duration`, 0), 0)) / 60) / 60, 2) AS `session_duration_total_hours`,
  CONCAT_WS(' ', `members`.`firstname`, `members`.`surname`) AS `member_name`,
  `members`.`email` AS `member_email`,
  `status`.`title` AS `member_status`
FROM ((((`tl_tools`
  JOIN `tl_members_tools` ON (`tl_tools`.`tool_id` = `tl_members_tools`.`tool_id`))
  JOIN `members` ON (`members`.`member_id` = `tl_members_tools`.`member_id`))
  JOIN `status` ON (`members`.`member_status` = `status`.`status_id`))
  LEFT JOIN `tl_tool_usages` ON (`members`.`member_id` = `tl_tool_usages`.`member_id`))
GROUP BY `tl_tools`.`tool_id`,`members`.`member_id`
ORDER BY
  `tl_tools`.`tool_id`,
  (CASE `tl_members_tools`.`mt_access_level`
    WHEN 'MAINTAINER' THEN 0
    WHEN 'INDUCTOR' THEN 1
    ELSE 2
    END),
  `session_duration_total_hours` DESC,
  SUM( IF(`tl_tool_usages`.`tool_id` = `tl_tools`.`tool_id`, 1, 0) ),
  CONCAT_WS(' ',`members`.`firstname`,`members`.`surname`);
