drop procedure if exists sp_tool_get_status;

/*
  Get details of all tools
*/

DELIMITER //
CREATE PROCEDURE sp_tool_get_status
(
   IN  p_tool_id int
)
SQL SECURITY DEFINER
BEGIN
  main: begin

  select
    t.id           as tool_id,
    t.name         as tool_name,
    t.status       as tool_status,
    t.restrictions as tool_restrictions,
    t.status_text  as tool_status_text,
    t.pph          as tool_pph,
    ifnull(convert (lst.start , char(40)), '<unknown>') as usage_start,
    ifnull(convert (timestampadd (SECOND, lst.duration, lst.start), char(40)), '<unknown>') as usage_end
  from tools t
  left outer join tool_usages lst on lst.id = (select max(tu.id) from tool_usages tu where tu.tool_id = t.id)
  where t.id = p_tool_id or p_tool_id = -1;

  end main;


END //
DELIMITER ;
