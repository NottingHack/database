DROP VIEW IF EXISTS `vw_payment`;

CREATE VIEW `vw_payment` AS
SELECT
  `m`.`username` AS `username
  m`.`member_id` AS `member_id
  t`.`transaction_datetime` AS `transaction_datetime
  t`.`transaction_id` AS `transaction_id
  t`.`amount` AS `amount
  t`.`transaction_desc` AS `transaction_desc`,
  (SELECT
      IFNULL(SUM(`pp`.`amount`), 0)
    FROM (`purchase_payment` `pp`
      JOIN `transactions` `t2` ON (`t2`.`transaction_id` = `pp`.`transaction_id_purchase`))
    WHERE ((`pp`.`transaction_id_payment` = `t`.`transaction_id`) AND (`t2`.`transaction_type` = 'VEND'))
  ) AS `for_vend`,
  (SELECT
      IFNULL(SUM(`pp`.`amount`), 0)
    FROM (`purchase_payment` `pp`
      JOIN `transactions` `t2` ON (`t2`.`transaction_id` = `pp`.`transaction_id_purchase`))
    WHERE ((`pp`.`transaction_id_payment` = `t`.`transaction_id`) AND (`t2`.`transaction_type` = 'TOOL'))
  ) AS `for_tool`,
  (SELECT
      IFNULL(SUM(`pp`.`amount`), 0)
    FROM (`purchase_payment` `pp`
      JOIN `transactions` `t2` ON (`t2`.`transaction_id` = `pp`.`transaction_id_purchase`))
    WHERE ((`pp`.`transaction_id_payment` = `t`.`transaction_id`) AND (`t2`.`transaction_type` NOT IN ('TOOL', 'VEND')))
  ) AS `for_other`
FROM (`transactions` `t`
  JOIN `members` `m` ON (`m`.`member_id` = `t`.`member_id`))
WHERE (`t`.`amount` > 0);
