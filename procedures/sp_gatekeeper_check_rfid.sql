drop procedure if exists sp_gatekeeper_check_rfid;

/*
  Check an rfid serial is valid, and return an approprite unlock text if it is.
  Then log an entry in the access log (either granted or denied).
*/

DELIMITER //
CREATE PROCEDURE sp_gatekeeper_check_rfid
(
   IN  p_rfid_serial    varchar(50),
   IN  p_door_id        int,
   IN  p_door_side      varchar(1),
   OUT p_display_msg    varchar(95),
   OUT p_username       varchar(50),
   OUT p_last_seen      varchar(100),
   OUT p_access_granted int,
   OUT p_new_zone_id    int,
   OUT p_member_id      int,
   OUT p_err            varchar(100)
)
SQL SECURITY DEFINER
BEGIN
  declare l_access_denied int;
  declare l_new_zone_id int;

  set p_member_id = NULL;
  set p_new_zone_id = -1;

  main: begin
    set p_access_granted = 0;

    -- get member_id from RFID serial
    call sp_check_rfid(p_rfid_serial, p_member_id, p_err);
    if (p_member_id is null) then
      set p_display_msg = concat('Access Denied: ', p_err);
      leave main;
    end if;

    -- Check the card belongs to either a member, or someone with specific access to open the door
    call sp_gatekeeper_check_door_access(p_member_id, p_door_id, p_door_side, p_new_zone_id, p_err, p_display_msg, l_access_denied);
    if (l_access_denied = 0) then
      set p_access_granted = 1;

      select
        coalesce(p.unlock_text, 'Welcome'),
        coalesce(u.username, '<unknown>')
      into
        p_display_msg,
        p_username
      from user u
      inner join profile p on p.user_id = u.id
      where u.id = p_member_id;
    else
      leave main;
    end if;

  end main;

  -- Get last seen text from access log
  call sp_last_seen(p_member_id, p_last_seen);

  -- add entry to access log
  if (p_access_granted = 1) then
    insert into access_logs (rfid_serial, pin, access_result, user_id, door_id, access_time)
    values (p_rfid_serial, null, 20, p_member_id, p_door_id, UTC_TIMESTAMP()); -- granted
  else
    insert into access_logs (rfid_serial, pin, access_result, user_id, denied_reason, door_id, access_time)
    values (p_rfid_serial, null, 10, p_member_id, p_err, p_door_id, UTC_TIMESTAMP()); -- denied
  end if;

END //
DELIMITER ;
