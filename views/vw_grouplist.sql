DROP VIEW IF EXISTS vw_grouplist;

CREATE VIEW vw_grouplist AS
SELECT
  -- rowid,
  '10000' AS gid,
  LOWER(m.username) AS username
FROM members m
WHERE m.username IS NOT NULL
  AND m.member_status = 5;
