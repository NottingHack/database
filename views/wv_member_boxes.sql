DROP VIEW IF EXISTS `wv_access_log`;

CREATE VIEW `wv_access_log` AS
SELECT
  `access_log`.`access_time` AS `access_time`,
  CONCAT_WS(' ', `members`.`firstname`, `members`.`surname`) AS `member_name`,
  `doors`.`door_description` AS `door`,
  `side_a_zone`.`zone_description` AS `zone_a`,
  `side_b_zone`.`zone_description` AS `zone_b`,
  (CASE
    WHEN (`access_log`.`access_result` = 10) THEN 'Denied'
    WHEN (`access_log`.`access_result` = 20) THEN 'Granted'
    END) AS `access_result`,
  `access_log`.`denied_reason` AS `denied_reason`
FROM ((((`access_log`
  LEFT join `members` ON (`members`.`member_id` = `access_log`.`member_id`))
  LEFT join `doors` ON (`doors`.`door_id` = `access_log`.`door_id`))
  LEFT join `zones` `side_a_zone` ON (`doors`.`side_a_zone_id` = `side_a_zone`.`zone_id`))
  LEFT join `zones` `side_b_zone` ON (`doors`.`side_b_zone_id` = `side_b_zone`.`zone_id`))
ORDER BY `access_log`.`access_time` DESC;
