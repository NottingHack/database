DROP VIEW IF EXISTS `wv_member_boxes`;

CREATE VIEW `wv_member_boxes` AS

SELECT
   -(5) AS member_box_id,
   count(*) AS user_id,
   '' AS member_name,
   '' AS bought_date,
   'In Use' AS box_status,
   'Any' AS member_status
FROM member_boxes
WHERE (member_boxes.state = 10)

UNION ALL

SELECT
   -(4) AS member_box_id,
   count(*) AS user_id,
   '' AS member_name,
   '' AS bought_date,
   'Removed' AS box_status,
   'Any' AS member_status
FROM member_boxes
WHERE (member_boxes.state = 20)

UNION ALL

SELECT
   -(3) AS member_box_id,
   count(*) AS user_id,
   '' AS member_name,
   '' AS bought_date,
   'Abandoned' AS box_status,
   'Any' AS member_status
FROM member_boxes
WHERE (member_boxes.state = 30)

UNION ALL

SELECT
   -(2) AS member_box_id,
   count(*) AS user_id,
   '' AS member_name,
   '' AS bought_date,
   'In Use' AS box_status,
   status.title AS member_status
FROM ((member_boxes
  JOIN members ON (member_boxes.member_id = members.member_id))
  LEFT JOIN status ON (members.member_status = status.status_id))
WHERE (member_boxes.state = 10)
   AND members.member_status = 5

UNION ALL

SELECT
   -(1) AS member_box_id,
   count(*) AS user_id,
   '' AS member_name,
   '' AS bought_date,
   'In Use' AS box_status,
   status.title AS member_status
FROM ((member_boxes
  JOIN members ON (member_boxes.member_id = members.member_id))
  LEFT JOIN status ON (members.member_status = status.status_id))
WHERE (member_boxes.state = 10)
   AND members.member_status = 6

UNION ALL

SELECT
   member_boxes.member_box_id AS member_box_id,
   member_boxes.member_id AS member_id,
   CONCAT_WS(' ', members.firstname, members.surname) AS member_name,
   member_boxes.bought_date AS bought_date,
   (CASE
    WHEN (member_boxes.state = 10) THEN 'In Use'
    WHEN (member_boxes.state = 20) THEN 'Removed'
    WHEN (member_boxes.state = 30) THEN 'Abandoned'
    END) AS box_status,
   status.title AS member_status
FROM ((member_boxes
  JOIN members ON (member_boxes.member_id = members.member_id))
  LEFT JOIN status ON (members.member_status = status.status_id));
