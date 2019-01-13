CREATE VIEW `vw_low_last_payment_date` AS
SELECT
  bt.account_id AS account_id,
  MAX(bt.transaction_date) AS last_payment_date
FROM bank_transactions bt
WHERE (bt.account_id IS NOT NULL)
GROUP BY bt.account_id;
