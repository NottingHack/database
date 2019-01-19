drop procedure if exists sp_gatekeeper_get_doors;

/*
  Get details of all doors
*/

DELIMITER //
CREATE PROCEDURE sp_gatekeeper_get_doors
(
   IN  p_door_id int
)
SQL SECURITY DEFINER
BEGIN
  main: begin

  select
    d.id          as door_id,
    d.description as door_description,
    d.short_name  as door_short_name,
    d.state       as door_state,
    d.state       as door_state
  from doors d
  where (d.id = p_door_id or p_door_id = -1);

  end main;
 

END //
DELIMITER ;
