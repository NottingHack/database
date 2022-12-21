CREATE VIEW `vw_low_payers` AS
SELECT
  u.id AS user_id,
  u.firstname AS firstname,
  u.lastname AS lastname,
  u.email AS email,
  lpa.account_id AS account_id,
  lpa.last_payment_date AS last_payment_date,
  (CASE
    WHEN u.account_id IN (SELECT vw_joint_accounts.account_id FROM vw_joint_accounts) THEN 'Yes' ELSE 'No'
    END) AS joint_account,
  (CASE
    WHEN u.account_id IN (SELECT vw_joint_accounts.account_id FROM vw_joint_accounts) THEN TRUNCATE(lpa.amount_pounds / 2, 2) ELSE TRUNCATE(lpa.amount_pounds, 2)
    END) AS adjustedAmount,
  IFNULL(lmv.visits1M, 0) AS visits1M,
  IFNULL(lmv.visits3M, 0) AS visits3M,
  IFNULL(TRUNCATE(lpa.amount_pounds / lmv.visits1M, 2), 0) AS `Payment/Visit 1M`,
  IFNULL(TRUNCATE((lpa.amount_pounds * 3) / lmv.visits3M, 2), 0) AS `Payment/Visit 3M`
FROM ((user u
  LEFT JOIN vw_low_last_payment_amount lpa ON (u.account_id = lpa.account_id))
  LEFT JOIN vw_low_members_visits lmv ON (u.id = lmv.user_id))
  INNER JOIN role_user ru ON (ru.user_id = u.id)
  INNER JOIN roles r ON (r.id = ru.role_id)
WHERE (r.name IN ('member.current', 'member.young') AND (lpa.last_payment_date IS NOT NULL));
