DROP VIEW IF EXISTS `vw_low_payers`;

CREATE VIEW `vw_low_payers` AS
SELECT
  `m`.`member_id` AS `member_id`,
  `m`.`firstname` AS `firstname`,
  `m`.`surname` AS `surname`,
  `m`.`email` AS `emial`,
  `lpa`.`account_id` AS `account_id`,
  `lpa`.`last_payment_date` AS `last_payment_date`,
  (CASE
    WHEN `m`.`account_id` IN (SELECT `vw_joint_accounts`.`account_id` FROM `vw_joint_accounts`) THEN 'Yes' ELSE 'No'
    END) AS `joint_account`,
  (CASE
    WHEN `m`.`account_id` IN (SELECT `vw_joint_accounts`.`account_id` FROM `vw_joint_accounts`) THEN TRUNCATE(`lpa`.`amount` / 2, 2) ELSE TRUNCATE(`lpa`.`amount`, 2)
    END) AS `adjustedAmount`,
  IFNULL(`lmv`.`visits1M`, 0) AS `visits1M`,
  IFNULL(`lmv`.`visits3M`, 0) AS `visits3M`,
  IFNULL(TRUNCATE(`lpa`.`amount` / `lmv`.`visits1M`, 2), 0) AS `Payment/Visit 1M`,
  IFNULL(TRUNCATE((`lpa`.`amount` * 3) / `lmv`.`visits3M`, 2), 0) AS `Payment/Visit 3M`
FROM ((`members` `m`
  LEFT JOIN `vw_low_last_payment_amount` `lpa` ON (`m`.`account_id` = `lpa`.`account_id`))
  LEFT JOIN `vw_low_members_visits` `lmv` ON (`m`.`member_id` = `lmv`.`member_id`))
WHERE ((`m`.`member_status` = 5) AND (`lpa`.`last_payment_date` IS NOT NULL));
