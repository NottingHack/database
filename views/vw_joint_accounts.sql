DROP VIEW IF EXISTS `vw_joint_accounts`

CREATE VIEW `vw_joint_accounts` AS
SELECT
  `m`.`account_id` AS `account_id`,
  `a`.`payment_ref` AS `payment_ref`
FROM (`members` `m`
  LEFT JOIN `account` `a` ON (`m`.`account_id` = `a`.`account_id`))
WHERE (`m`.`account_id` IS NOT NULL)
GROUP BY `m`.`account_id`
HAVING (count(0) > 1);
