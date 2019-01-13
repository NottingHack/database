DROP VIEW IF EXISTS `wv_snackspace_debt`;

CREATE VIEW `wv_snackspace_debt` AS
SELECT
  -(1) AS `member_id`,
  'TOTAL' AS `member_name`,
  '' AS `member_status`,
  TRUNCATE( SUM(`transactions`.`amount`) / 100), 2) AS `balance`,
  TRUNCATE( ABS( SUM( IF(`transactions`.`amount` < 0, `transactions`.`amount`, 0) ) / 100), 2) AS `debit`,
  TRUNCATE( ABS( SUM( IF(`transactions`.`amount` > 0, `transactions`.`amount`, 0) ) / 100), 2) AS `credit`
FROM `transactions`
WHERE (`transactions`.`transaction_status` = 'COMPLETE')
UNION ALL
SELECT
  -(1) AS `member_id`,
  'BAD DEBT' AS `member_name`,'' AS `member_status`,
  TRUNCATE( SUM(`transactions`.`amount`) / 100), 2) AS `balance`,
  TRUNCATE( ABS( SUM( IF(`transactions`.`amount` < 0, `transactions`.`amount`, 0) ) / 100), 2) AS `debit`,
  TRUNCATE( ABS( SUM( IF(`transactions`.`amount` > 0, `transactions`.`amount`, 0) ) / 100), 2) AS `credit`
FROM (`transactions`
  JOIN `members` ON (`members`.`member_id` = `transactions`.`member_id`))
WHERE ((`transactions`.`transaction_status` = 'COMPLETE') AND (`members`.`member_status` > 5))
UNION ALL
SELECT
  `members`.`member_id` AS `member_id`,
  CONCAT_WS(' ',`members`.`firstname`,`members`.`surname`) AS `member_name`,
  `status`.`title` AS `member_status`,
  TRUNCATE( `members`.`balance` / 100), 2) AS `balance`,
  TRUNCATE( ABS( SUM( IF(`transactions`.`amount` < 0, `transactions`.`amount`, 0) ) / 100), 2) AS `debit`,
  TRUNCATE( ABS( SUM( IF(`transactions`.`amount` > 0, `transactions`.`amount`, 0) ) / 100), 2) AS `credit`
FROM ((`members`
  LEFT JOIN `status` ON (`members`.`member_status` = `status`.`status_id`))
  LEFT JOIN `transactions` ON ((`members`.`member_id` = `transactions`.`member_id`) AND (`transactions`.`transaction_status` = 'COMPLETE')))
WHERE (`members`.`member_status` > 3)
GROUP BY `members`.`member_id`
ORDER BY `balance`;
