DROP VIEW IF EXISTS vw_users;

CREATE VIEW vw_users AS
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
WHERE u.username IS NOT NULL
  AND r.name IN ('member.current', 'member.young');
