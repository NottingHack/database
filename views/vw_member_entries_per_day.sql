DROP VIEW IF EXISTS `vw_member_entries_per_day`;

CREATE VIEW `vw_member_entries_per_day` AS
SELECT
  `al`.`member_id` AS `member_id`,
  `m`.`firstname` AS `firstname`,
  `m`.`surname` AS `surname`,
  CAST(`al`.`access_time` AS DATE) AS `date`,
  COUNT(0) AS `entries`
FROM (`access_log` `al`
  LEFT JOIN `members` `m` ON (`al`.`member_id` = `m`.`member_id`))
WHERE (`al`.`member_id` IS NOT NULL)
GROUP BY `al`.`member_id`, CAST(`al`.`access_time` AS DATE);
