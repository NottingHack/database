CREATE VIEW `vw_joint_accounts` AS
SELECT
  u.account_id AS account_id,
  a.payment_ref AS payment_ref,
  count(*) AS count
FROM user u
  LEFT JOIN accounts a ON (a.id = u.account_id)
WHERE u.account_id IS NOT NULL
GROUP BY account_id, payment_ref
HAVING COUNT(0) > 1;
