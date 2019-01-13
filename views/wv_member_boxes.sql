DROP VIEW IF EXISTS `wv_member_boxes`;

CREATE VIEW `wv_member_boxes` AS
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
