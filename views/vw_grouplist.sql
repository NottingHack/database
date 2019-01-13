DROP VIEW IF EXISTS vw_grouplist;

CREATE VIEW vw_grouplist AS
SELECT
  -- rowid,
  '10000' AS gid,
  LOWER(u.username) AS username
FROM user u
  INNER JOIN role_user ru ON (ru.user_id = u.id)
  INNER JOIN roles r ON (r.id = ru.role_id)
WHERE u.username IS NOT NULL
  AND r.name IN ('member.current', 'member.young');
