CREATE VIEW `vw_grouplist` AS
SELECT
  -- rowid,
  '10000' AS gid,
  LOWER(u.username) AS username
FROM user u
  INNER JOIN role_user ru ON (ru.user_id = u.id)
  INNER JOIN roles r ON (r.id = ru.role_id)
  INNER JOIN permission_role pr ON pr.role_id = r.id
  INNER JOIN permissions p ON p.id = pr.permission_id
WHERE p.name IN ('login.shell');
