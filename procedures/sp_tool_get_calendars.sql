drop procedure if exists sp_tool_get_calendars;

/*
  Get details of all tools that should have there bookings published
*/

DELIMITER //
CREATE PROCEDURE sp_tool_get_calendars
(
   IN  p_tool_id int
)
SQL SECURITY DEFINER
BEGIN
  main: begin  

    select
      t.id   as tool_id,
      t.name as tool_name
    from tools t
    where (t.id = p_tool_id or p_tool_id = -1);

  end main;

END //
DELIMITER ;
