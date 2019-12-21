CREATE VIEW `vw_laser_usage` AS
SELECT
  YEAR(tu.start) AS year,
  MONTHNAME(tu.start) AS month,
  SEC_TO_TIME(SUM(tu.duration)) AS total_time,
  SEC_TO_TIME(SUM(CASE WHEN tu.tool_id=1 THEN tu.duration ELSE 0 END)) AS a0_time,
  SEC_TO_TIME(SUM(CASE WHEN tu.tool_id=14 THEN tu.duration ELSE 0 END)) AS a2_time,
  SEC_TO_TIME(SUM(CASE WHEN tu.status="CHARGED" THEN tu.duration ELSE 0 END)) AS charged_time,
  FORMAT(SUM(CASE WHEN tu.status="CHARGED" THEN tu.duration ELSE 0 END)*(3/60/60), 2) AS charged_income,
  COUNT(DISTINCT(tu.user_id)) AS distinct_users,
  (
    SELECT COUNT(*)
    FROM role_updates ru
    INNER JOIN roles r ON r.id = ru.added_role_id
    WHERE r.name = 'tools.laser.user'
      AND YEAR(ru.created_at)=YEAR(tu.start)
      AND MONTH(ru.created_at)=MONTH(tu.start)
  ) AS members_inducted
FROM tool_usages tu
WHERE tu.tool_id IN (1, 14)
  AND tu.duration > 0
GROUP BY YEAR(tu.start), MONTHNAME(tu.start)
ORDER BY YEAR(tu.start) DESC, MONTH(tu.start) DESC;
