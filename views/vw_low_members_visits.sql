DROP VIEW IF EXISTS `vw_low_members_visits`;

CREATE VIEW `vw_low_members_visits` AS
SELECT
  `mepd`.`member_id` AS `member_id`,
  `m`.`firstname` AS `firstname`,
  `m`.`surname` AS `surname`,
  COUNT(IF(`mepd`.`date` >= (NOW() - INTERVAL 1 MONTH), 1, NULL)) AS `visits1M`,
  COUNT(IF(`mepd`.`date` >= (NOW() - INTERVAL 3 MONTH), 1, NULL)) AS `visits3M`
FROM (`vw_member_entries_per_day` `mepd`
  LEFT JOIN `members` `m` ON (`mepd`.`member_id` = `m`.`member_id`))
WHERE (`mepd`.`member_id` IS NOT NULL)
GROUP BY `mepd`.`member_id`;
