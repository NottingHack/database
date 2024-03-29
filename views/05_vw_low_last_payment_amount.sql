CREATE VIEW `vw_low_last_payment_amount` AS
SELECT
  bt.account_id AS account_id,
  a.payment_ref AS payment_ref,
  lpd.last_payment_date AS last_payment_date,
  bt.amount AS amount,
  TRUNCATE(bt.amount / 100, 2) AS amount_pounds,
  (SELECT count(*) FROM user u WHERE u.account_id = bt.account_id) AS joint_count,
  TRUNCATE(bt.amount / GREATEST(1, (SELECT count(*) FROM user u WHERE u.account_id = bt.account_id)), 0) AS amount_joint_adjusted
FROM ((bank_transactions bt
  LEFT JOIN vw_low_last_payment_date lpd ON (bt.account_id = lpd.account_id))
  LEFT JOIN accounts a ON (bt.account_id = a.id))
WHERE (bt.transaction_date = lpd.last_payment_date);
