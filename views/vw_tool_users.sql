CREATE VIEW `vw_tool_users`AS
SELECT
  REGEXP_SUBSTR(rt.display_name, '(?<=Tool: ).+(?= )') AS tool,
  (SELECT t.id FROM tools t WHERE t.name = tool) AS tool_id,
  SUBSTRING_INDEX(rt.display_name," ",-1) AS access_level,
  (SELECT
      COUNT(*)
    FROM tool_usages tu
    WHERE tu.tool_id = tool_id AND tu.user_id = u.id) AS session_count,
  (SELECT
      ROUND( SUM(tu.duration) / 60 / 60, 2)
    FROM tool_usages tu
    WHERE tu.tool_id = tool_id AND tu.user_id = u.id) AS session_duration_total_hours,
  CONCAT_WS(' ', u.firstname, u.lastname) AS user_name,
  r.display_name AS member_status
FROM  roles rt
  LEFT JOIN role_user rtu ON (rt.id = rtu.role_id)
  LEFT JOIN user u ON (rtu.user_id = u.id)
  LEFT JOIN tool_usages tu ON (tu.user_id = u.id)
  INNER JOIN role_user ru ON (ru.user_id = u.id)
  INNER JOIN roles r ON (r.id = ru.role_id)
WHERE rt.name LIKE 'tools.%' AND r.name LIKE 'member.%'
GROUP BY tu.tool_id, u.id
ORDER BY
  tool,
  (CASE access_level
    WHEN 'Maintainer' THEN 0
    WHEN 'Inductor' THEN 1
    ELSE 2
    END),
  user_name;
