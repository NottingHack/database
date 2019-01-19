drop procedure if exists sp_gatekeeper_get_door_bells;

/*
  Get details of all bells that should be rang with the door bell button for door_id is pushed
*/

DELIMITER //
CREATE PROCEDURE sp_gatekeeper_get_door_bells
(
   IN  p_door_id int
)
SQL SECURITY DEFINER
BEGIN
  main: begin

    select distinct
      b.topic   as bell_topic,
      b.message as bell_message
    from doors d
    inner join door_bell db on db.door_id = d.id
    inner join bells b on b.id = db.bell_id
    where b.enabled = 1
      and d.id = p_door_id;

  end main;
 

END //
DELIMITER ;
