DROP VIEW IF EXISTS `vw_low_members_visits`;

CREATE VIEW `vw_low_members_visits` AS
SELECT
  mepd.user_id AS user_id,
  u.firstname AS firstname,
  u.lastname AS lastname,
  COUNT(IF(mepd.date >= (NOW() - INTERVAL 1 MONTH), 1, NULL)) AS visits1M,
  COUNT(IF(mepd.date >= (NOW() - INTERVAL 3 MONTH), 1, NULL)) AS visits3M
FROM (vw_member_entries_per_day mepd
  LEFT JOIN user u ON (mepd.user_id = u.id))
WHERE (mepd.user_id IS NOT NULL)
GROUP BY mepd.user_id;
