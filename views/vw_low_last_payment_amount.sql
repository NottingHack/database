DROP VIEW IF EXISTS  `vw_low_last_payment_amount`;

CREATE VIEW `vw_low_last_payment_amount` AS
SELECT
  `bt`.`account_id` AS `account_id`,
  `a`.`payment_ref` AS `payment_ref`,
  `lpd`.`last_payment_date` AS `last_payment_date`,
  `bt`.`amount` AS `amount`
FROM ((`bank_transactions` `bt`
  LEFT JOIN `vw_low_last_payment_date` `lpd` ON (`bt`.`account_id` = `lpd`.`account_id`))
  LEFT JOIN `account` `a` ON (`bt`.`account_id` = `a`.`account_id`))
WHERE (`bt`.`transaction_date` = `lpd`.`last_payment_date`);
