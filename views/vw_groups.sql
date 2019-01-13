DROP VIEW IF EXISTS vw_groups;

CREATE VIEW vw_groups AS
SELECT
  'members' AS name,
  'x' AS password,
  '10000' AS gid;
