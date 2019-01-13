CREATE VIEW `vw_member_boxes` AS
SELECT
   member_boxes.id AS member_box_id,
   member_boxes.user_id AS user_id,
   CONCAT_WS(' ', u.firstname, u.lastname) AS member_name,
   member_boxes.bought_date AS bought_date,
   (CASE
     WHEN (member_boxes.state = 10) THEN 'In Use'
     WHEN (member_boxes.state = 20) THEN 'Removed'
     WHEN (member_boxes.state = 30) THEN 'Abandoned'
     END) AS box_status,
   r.display_name AS member_status
FROM member_boxes
  JOIN user u ON (member_boxes.user_id = u.id)
  INNER JOIN role_user ru ON (ru.user_id = u.id)
  INNER JOIN roles r ON (r.id = ru.role_id)
WHERE r.name LIKE 'member.%'
