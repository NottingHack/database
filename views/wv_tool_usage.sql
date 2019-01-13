DROP VIEW IF EXSITS `wv_tool_usage`;

CREATE VIEW `wv_tool_usage` AS
SELECT
  `tl_tools`.`tool_id` AS `tool_id`,
  `tl_tools`.`tool_name` AS `tool_name`,
  `members`.`member_id` AS `member_id`,
  CONCAT_WS(' ', `members`.`firstname`,
  `members`.`surname`) AS `member_name`,
  `members`.`email` AS `member_email`,
  DATE_FORMAT(`tl_tool_usages`.`usage_start`, '%d/%m/%Y %H:%i:%s') AS `time`,
  (`tl_tool_usages`.`usage_duration` / 60) AS `usage_mins`
FROM ((`tl_tool_usages`
  JOIN `tl_tools` ON (`tl_tool_usages`.`tool_id` = `tl_tools`.`tool_id`))
  JOIN `members` ON (`tl_tool_usages`.`member_id` = `members`.`member_id`))
ORDER BY `tl_tool_usages`.`usage_start` DESC;
