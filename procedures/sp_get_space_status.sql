
drop procedure if exists sp_get_space_status;

/*


*/

DELIMITER //
CREATE PROCEDURE sp_get_space_status
(
  OUT space_open  varchar(10),
  OUT last_change int
)
SQL SECURITY DEFINER
BEGIN
      
  select 
    case type
      when 'FIRST_IN' then 'Yes'
      when 'LAST_OUT' then 'No'
      else '???'
    end as state,
    unix_timestamp(time)
  into
    space_open,
    last_change
  from events
  where type in ("LAST_OUT","FIRST_IN")
  order by time desc 
  limit 1;


  select 
    t.name as sensor, 
    cast(t.temperature as char(5)) as temp
  from temperature t
  where t.name is not null;
  
  
END //
DELIMITER ;

