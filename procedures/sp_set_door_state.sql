drop procedure if exists sp_set_door_state;
/*

*/

DELIMITER //
CREATE PROCEDURE sp_set_door_state 
(
   IN   p_door_id     int,
   IN   p_door_state  varchar(10)
)
SQL SECURITY DEFINER
BEGIN

  main: begin
  
    declare evt varchar(100);
    
    set evt = case 
        when p_door_state = 'OPEN'   then 'DOOR_OPENED' 
        when p_door_state = 'CLOSED' then 'DOOR_CLOSED'
        when p_door_state = 'LOCKED' then 'DOOR_LOCKED'
        else 'UNKNOWN'
      end;
    
    update doors
    set 
      state        = p_door_state,
      state_change = UTC_TIMESTAMP()
    where id = p_door_id;

  call sp_log_event(evt, p_door_id);

  end main;


END //
DELIMITER ;

