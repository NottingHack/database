CREATE VIEW `vw_tool_inductors_maintainers` AS
SELECT
  REGEXP_SUBSTR(rt.display_name, '(?<=Tool: ).+(?= )') AS tool_name,
  SUBSTRING_INDEX(rt.display_name," ",-1) AS access_level,
  CONCAT_WS(' ', u.firstname, u.lastname) AS user_name,
  r.display_name AS member_status,
  u.email AS email
FROM roles rt
  LEFT JOIN role_user rtu ON (rt.id = rtu.role_id)
  LEFT JOIN user u ON (rtu.user_id = u.id)
  INNER JOIN role_user ru ON (ru.user_id = u.id)
  INNER JOIN roles r ON (r.id = ru.role_id)
WHERE (rt.name LIKE 'tools.%.inductor' OR rt.name LIKE 'tools.%.maintainer') AND r.name LIKE 'member.%'
ORDER BY
  tool_name,
  (CASE access_level
    WHEN 'Maintainer' THEN 0
    WHEN 'Inductor' THEN 1
    ELSE 2
    END),
  user_name;
