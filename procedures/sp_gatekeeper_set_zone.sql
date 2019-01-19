
drop procedure if exists sp_gatekeeper_set_zone;

/*
  Update the zone_occupancy table with the new zone the of member, and log an entry to zone_occupancy_log
  to record what time the previous zone was entered/left
  
*/

DELIMITER //
CREATE PROCEDURE sp_gatekeeper_set_zone
(
   IN  p_member_id    int,
   IN  p_new_zone_id  int
)
SQL SECURITY DEFINER
BEGIN

  declare ck_exists int;
  declare old_zone_id int;
  declare old_time_entered timestamp;
  set ck_exists = 0;

  -- First, check if there is already an entry in zone_occupancy table for the member
  select count(*) into ck_exists
  from zone_occupants z
  where z.user_id = p_member_id;
  
  if (ck_exists = 0) then
    insert into zone_occupants (zone_id      , user_id    )
                        values (p_new_zone_id, p_member_id);
  else
    -- get previous zone
    select 
      z.zone_id,
      z.time_entered
    into 
      old_zone_id,
      old_time_entered
    from zone_occupants z
    where z.user_id = p_member_id;

    -- update record with new zone
    update zone_occupants
    set 
      zone_id = p_new_zone_id,
      time_entered = sysdate()
    where user_id = p_member_id;

    -- record log entry for old zone
    insert into zone_occupancy_logs (zone_id    , user_id    , time_entered    , time_exited)
                             values (old_zone_id, p_member_id, old_time_entered, sysdate());

  end if;
END //
DELIMITER ;
