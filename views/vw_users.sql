DROP VIEW IF EXISTS vw_users;

CREATE VIEW vw_users AS
SELECT
  LOWER(m.username) AS username,
  member_id + 10000 AS uid,
  10000 AS gid,
  '' AS gecos,
  CONCAT('/home/', LOWER(m.username)) AS homedir,
  '/bin/bash' AS shell,
  'x' AS password,
  '1' AS lstchg,
  '0' AS min,
  '99999' AS max,
  '0' AS warn,
  '0' AS inact,
  '-1' AS expire,
  '0' AS flag
FROM members m
WHERE m.username IS NOT NULL
  AND m.member_status = 5;
