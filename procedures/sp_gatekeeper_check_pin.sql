drop procedure if exists sp_gatekeeper_check_pin;

/*

  Check a pin is valid, and return an approprite unlock text if it is.
  If the PIN is found and is set to enroll, register the last card read 
  (if within timeout).
  If registation is successfull, cancel the PIN.
  
  In all cases, log an entry in the access log.
*/

DELIMITER //
CREATE PROCEDURE sp_gatekeeper_check_pin
(
   IN  p_pin          varchar(12),
   IN  p_door_id      int,
   IN  p_door_side    varchar(1),
   OUT p_member_id    int,
   OUT p_new_zone_id  int,
   OUT p_unlock_text  varchar(95),
   OUT p_username     varchar(50),
   OUT p_err          varchar(100)
)
SQL SECURITY DEFINER
BEGIN
  declare ck_exists int;
  declare l_access_granted int;
  
  declare l_pin_id int;
  declare l_expiry timestamp;
  declare l_state int;

  declare l_rfid_serial varchar(50);
  declare l_access_result int;
  declare l_access_time timestamp;
  declare l_access_denied int;

  set ck_exists = 0;
  set l_access_granted = 0;
  set p_member_id = NULL;

  main: begin

    -- First, see if the pin is known
    select count(*) into ck_exists
    from pins p
    where p.pin = p_pin
      and p.state in (10, 40); -- active, enroll

    if (ck_exists != 1) then
      set p_err = "PIN not found";
      set p_unlock_text = "Access Denied";
      leave main;
    end if;

    select
      p.id,
      m.unlock_text,
      p.expiry,
      p.state,
      u.id,
      coalesce(u.username, '<unknown>')
    into
      l_pin_id,
      p_unlock_text,
      l_expiry,
      l_state,
      p_member_id,
      p_username
    from pins p
    inner join user u on p.user_id = u.id
    inner join profile m on m.user_id = u.id
    where p.pin = p_pin
      and p.state in (10, 40); -- active, enroll

    -- check pin has not expired
    if (l_expiry < UTC_TIMESTAMP()) then
      set p_err = "PIN expired";
      set p_unlock_text = "Access Denied";

      -- now update to expired
      update pins
      set state = 20 -- expired
      where id = l_pin_id;

      leave main;
    end if;

    -- Check the PIN belongs to either a member, or someone with specific access to open the door
    call sp_gatekeeper_check_door_access(p_member_id, p_door_id, p_door_side, p_new_zone_id, p_err, p_unlock_text, l_access_denied);
    if (l_access_denied != 0) then
      -- Access is denied
      leave main;
    end if;

    -- Check for an enroll pin (to register a card)
    if (
          (l_state = 40) and -- enroll
          (p_member_id is not null)
        )
    then
      select 
        l.access_time,
        l.rfid_serial,
        l.access_result
      into
        l_access_time,
        l_rfid_serial,
        l_access_result
      from access_logs l
      where l.rfid_serial is not null
        and l.door_id = p_door_id
      order by id 
      desc limit 1;

      -- check an RFID card was found to register
      if (l_rfid_serial is null) then
        set p_err = 'No suitable record found in access_logs';
        set p_unlock_text = concat('Unlock:', coalesce(p_unlock_text, 'Welcome'));
        set l_access_granted = 1;
        leave main;
      end if;

      -- check the card is suitable (not unknown type)
      if (l_rfid_serial = 'Unknown Card Type') then
        set p_err = 'Unknown Card Type';
        set p_unlock_text = concat('Unlock:', coalesce(p_unlock_text, 'Welcome'));
        set l_access_granted = 1;
        leave main;
      end if;

      -- check the card is suitable (not already registered)
      select count(*) into ck_exists
      from rfid_tags t
      where t.rfid_serial = l_rfid_serial;

      -- Card not suitable, but PIN was valid, so unlock
      if (ck_exists > 0) then
        set p_err = "Card already registerd!";
        set p_unlock_text = concat('Unlock:', coalesce(p_unlock_text, 'Welcome'));
        set l_access_granted = 1;
        leave main;
      end if;

      -- Check time hasn't expired
      if ((unix_timestamp(UTC_TIMESTAMP()) - unix_timestamp(l_access_time)) > 60) then
        set p_err = "Time expired!";
        set p_unlock_text = concat('Unlock:',  coalesce(p_unlock_text, 'Welcome'));
        set l_access_granted = 1;
        leave main;
      end if;

      -- To get this far, everything should be in order, so register the card
      call sp_add_card(p_member_id, l_rfid_serial, p_err);
      if (p_err is null) then
        set p_unlock_text = concat('Unlock:', 'Card registered, PIN cancelled!');
        set l_access_granted = 1;

        -- Now a card has been registered using it, cancel the PIN
        update pins
        set state = 30 -- cancelled
        where id = l_pin_id;

        leave main;
      else
        -- Somethings gone wrong - the card couldn't be registered
        set p_unlock_text = concat('Unlock:', 'Card registration failed.');
        set l_access_granted = 1;
        set p_err = "Failed to register card!";
        leave main;
      end if;
    else
      -- regular, non-expired PIN
      set p_unlock_text = concat('Unlock:',  coalesce(p_unlock_text, 'Welcome'));
      set l_access_granted = 1;
      set p_err = null;
      leave main;
    end if;

  end main;

  if (l_access_granted = 1) then
    insert into access_logs (rfid_serial, pin, access_result, user_id, door_id, access_time)
    values (null, p_pin, 20, p_member_id, p_door_id, UTC_TIMESTAMP()); -- granted
  else
    insert into access_logs (rfid_serial, pin, access_result, user_id, denied_reason, door_id, access_time)
    values (null, p_pin, 10, p_member_id, p_err, p_door_id, UTC_TIMESTAMP()); -- denied
  end if;

END //
DELIMITER ;
