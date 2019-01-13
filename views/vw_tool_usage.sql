CREATE VIEW `vw_tool_usage` AS
SELECT
  t.id AS tool_id,
  t.name AS tool_name,
  u.id AS user_id,
  CONCAT_WS(' ', u.firstname, u.lastname) AS user_name,
  u.email AS user_email,
  DATE_FORMAT(tu.start, '%d/%m/%Y %H:%i:%s') AS time,
  (tu.duration / 60) AS usage_mins
FROM ((tool_usages tu
  JOIN tools t ON (tu.tool_id = t.id))
  JOIN user u ON (tu.user_id = u.id))
ORDER BY tu.start DESC;
