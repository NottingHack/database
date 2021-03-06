CREATE VIEW `vw_users` AS
SELECT
  LOWER(u.username) AS username,
  u.id + 10000 AS uid,
  10000 AS gid,
  '' AS gecos,
  CONCAT('/home/', LOWER(u.username)) AS homedir,
  '/bin/bash' AS shell,
  'x' AS password,
  '1' AS lstchg,
  '0' AS min,
  '99999' AS max,
  '0' AS warn,
  '0' AS inact,
  '-1' AS expire,
  '0' AS flag
FROM user u
  INNER JOIN role_user ru ON (ru.user_id = u.id)
  INNER JOIN roles r ON (r.id = ru.role_id)
  INNER JOIN permission_role pr ON pr.role_id = r.id
  INNER JOIN permissions p ON p.id = pr.permission_id
WHERE p.name IN ('login.shell');
