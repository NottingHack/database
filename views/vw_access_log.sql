CREATE VIEW `vw_access_log` AS
SELECT
  al.access_time AS access_time,
  u.id as user_id,
  CONCAT_WS(' ', u.firstname, u.lastname) AS member_name,
  d.description AS door,
  side_a_zone.description AS zone_a,
  side_b_zone.description AS zone_b,
  (CASE
    WHEN (al.access_result = 10) THEN 'Denied'
    WHEN (al.access_result = 20) THEN 'Granted'
    END) AS access_result,
  al.denied_reason AS denied_reason
FROM ((((access_logs al
  LEFT JOIN user u ON (u.id = al.user_id))
  LEFT JOIN doors d ON (d.id = al.door_id))
  LEFT JOIN zones side_a_zone ON (d.side_a_zone_id = side_a_zone.id))
  LEFT JOIN zones side_b_zone ON (d.side_b_zone_id = side_b_zone.id))
ORDER BY al.access_time DESC;
