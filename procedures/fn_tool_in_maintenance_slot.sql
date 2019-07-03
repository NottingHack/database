drop function if exists fn_tool_in_maintenance_slot;

/*
  Check if tool_id is currently in a maintenance slot
 */


DELIMITER //
CREATE FUNCTION fn_tool_in_maintenance_slot
(
    p_tools_id int
)
returns int
DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
BEGIN

  declare c int;
  set c = 0;

  select count(*)
  into c
  from bookings b
  where b.start >= UTC_TIMESTAMP()
    and b.end <= UTC_TIMESTAMP()
    and tool_id = p_tools_id
    and b.type = 'MAINTENANCE';

  if (c >= 1) then
    set c = 1;
  else
    set c = 0;
  end if;

  return c;

END //
DELIMITER ;
