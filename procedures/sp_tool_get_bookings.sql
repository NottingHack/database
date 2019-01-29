drop procedure if exists sp_tool_get_bookings;

/*
  Get bookings for a tool
*/

DELIMITER //
CREATE PROCEDURE sp_tool_get_bookings
(
   IN  p_tool_id int
)
SQL SECURITY DEFINER
BEGIN
  main: begin  

    select
      b.id,
      b.start,
      b.end,
      u.username
    from bookings b
    inner join user u on u.id = b.user_id
    where (b.tool_id = p_tool_id);

  end main;

END //
DELIMITER ;
