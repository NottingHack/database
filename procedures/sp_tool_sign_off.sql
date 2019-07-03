drop procedure if exists sp_tool_sign_off;

DELIMITER //
CREATE PROCEDURE sp_tool_sign_off
(
   IN  p_tool_name          varchar(20),
   IN  p_usage_active_time  int,
   OUT p_msg                varchar(200)
)
SQL SECURITY DEFINER
BEGIN
  
  declare cnt int;
  declare tool_status varchar(20);
  declare done int default false;
  declare usage_id int;
  declare l_tool_id int;

  declare tool_use_cur cursor for
    select tu.id
    from tool_usages tu
    inner join tools t on t.id = tu.tool_id
    where tu.status = 'IN_PROGRESS'
      and t.name = p_tool_name;

  declare continue handler for not found set done = TRUE;

  set p_msg = '';

  main: begin

    -- Check tool name is actaully known
    select count(*)
    into cnt
    from tools t
    where t.name = p_tool_name;

    if (cnt = 0) then
      set p_msg = 'Tool not configured';
    leave main;
    elseif (cnt > 1) then
      set p_msg = 'Tool config error';
      leave main;
    end if;

    -- Get tool status
    select
      t.status,
      t.id
    into
      tool_status,
      l_tool_id
    from tools t
    where t.name = p_tool_name;

    -- Set the tool's status back to free if applicable
    if (tool_status = 'IN_USE') then
      update tools
      set status = 'FREE'
      where tools.id = l_tool_id;
    end if;

    open tool_use_cur;

    read_loop: LOOP
      fetch tool_use_cur into usage_id;

      if done then
        leave read_loop;
      end if;

      call sp_tool_charge(usage_id, UTC_TIMESTAMP(), p_usage_active_time, p_msg);

      set p_usage_active_time = 0;

    end loop;
  end main;

END //
DELIMITER ;
