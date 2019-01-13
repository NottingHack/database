CREATE VIEW `vw_snackspace_debt` AS
SELECT
  -(1) AS user,
  'TOTAL' AS user_name,
  '' AS member_status,
  TRUNCATE( SUM(t.amount) / 100, 2) AS balance,
  TRUNCATE( ABS( SUM( IF(t.amount < 0, t.amount, 0) ) / 100), 2) AS debit,
  TRUNCATE( ABS( SUM( IF(t.amount > 0, t.amount, 0) ) / 100), 2) AS credit
FROM transactions t
WHERE (t.transaction_status = 'COMPLETE')
UNION ALL
SELECT
  -(1) AS user,
  'BAD DEBT' AS user_name,
  '' AS member_status,
  TRUNCATE( SUM(t.amount) / 100, 2) AS balance,
  TRUNCATE( ABS( SUM( IF(t.amount < 0, t.amount, 0) ) / 100), 2) AS debit,
  TRUNCATE( ABS( SUM( IF(t.amount > 0, t.amount, 0) ) / 100), 2) AS credit
FROM transactions t
  JOIN user u ON (u.id = t.user_id)
  INNER JOIN role_user ru ON (ru.user_id = u.id)
  INNER JOIN roles r ON (r.id = ru.role_id)
WHERE ((t.transaction_status = 'COMPLETE') AND (r.name in ('member.ex', 'member.banned')))
UNION ALL
SELECT
  u.id AS user,
  CONCAT_WS(' ', u.firstname, u.lastname) AS user_name,
  r.display_name AS member_status,
  TRUNCATE( p.balance / 100, 2) AS balance,
  TRUNCATE( ABS( SUM( IF(t.amount < 0, t.amount, 0) ) / 100), 2) AS debit,
  TRUNCATE( ABS( SUM( IF(t.amount > 0, t.amount, 0) ) / 100), 2) AS credit
FROM user u
  JOIN profile p ON (p.user_id = u.id)
  LEFT JOIN transactions t ON ((u.id = t.user_id) AND (t.transaction_status = 'COMPLETE'))
  INNER JOIN role_user ru ON (ru.user_id = u.id)
  INNER JOIN roles r ON (r.id = ru.role_id)
WHERE (r.name IN ('member.current', 'member.young', 'member.ex', 'member.temporarybanned', 'member.banned'))
GROUP BY u.id, user_name, member_status, balance
ORDER BY balance;
