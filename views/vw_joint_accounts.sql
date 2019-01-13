DROP VIEW IF EXISTS `vw_joint_accounts`

CREATE VIEW `vw_joint_accounts` AS
SELECT
  u.account_id AS account_id,
  a.payment_ref AS payment_ref
FROM (user u
  LEFT JOIN accounts a ON (u.account_id = a.id))
WHERE (u.account_id IS NOT NULL)
GROUP BY u.account_id
HAVING (count(0) > 1);
