CREATE VIEW `vw_member_entries_per_day` AS
SELECT
  u.id AS user_id,
  u.firstname AS firstname,
  u.lastname AS lastname,
  CAST(al.access_time AS DATE) AS date,
  COUNT(0) AS entries
FROM (access_logs al
  LEFT JOIN user u ON (al.user_id = u.id))
WHERE (al.user_id IS NOT NULL)
GROUP BY u.id, u.firstname, u.lastname, CAST(al.access_time AS DATE);
