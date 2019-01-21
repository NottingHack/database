drop procedure if exists sp_gatekeeper_check_door_access;

/*
  Check if member_id has permission to open door_id.

  Using p_door_side, determine what zone is being accessed, and check that the user has permission to enter that zone.

  Sets access_denied:
    0 - access granted
    1 - access denied: ex-member
    2 - access denied: no permission to open door
    3 - (unused / put next reason here)
    4 - access denied: Banned member
   97 - access denied: NULL zone id for door side encountered (bad config data)
   98 - access denied: invalid door side (i.e. bug somewhere)
   99 - access denied: other
*/

DELIMITER //
CREATE PROCEDURE sp_gatekeeper_check_door_access
(
   IN  p_member_id      int,
   IN  p_door_id        int,
   IN  p_door_side      varchar(1),
   OUT p_new_zone_id    int,
   OUT p_err            varchar(100),
   OUT p_display_msg    varchar(95),
   OUT p_access_denied  int
)
SQL SECURITY DEFINER
BEGIN

  declare l_permission_code   varchar(100);
  declare l_access_granted    int;
  declare l_side_a_zone_id    int;
  declare l_side_b_zone_id    int;

  declare l_door_current_zone int; -- Zone on the side of the door where the card was read
  declare l_door_new_zone     int; -- Zone on the opposide side of door_side
  declare l_db_zone_id        int; -- Zone recorded in the database against the member

  declare ck_exists int;

  -- If any data is missing -> access denied
  declare exit handler for not found
  begin
    set p_access_denied = 99;
  end;

  main: begin

    set p_new_zone_id = -1;
    set p_door_side = upper(p_door_side);
    set p_access_denied = 99;
    if (p_door_side = '') or p_door_side is null then
      set p_access_denied = 98;
      leave main;
    end if;

    -- get details of door
    select
      d.side_a_zone_id,
      d.side_b_zone_id
    into
      l_side_a_zone_id,
      l_side_b_zone_id
    from doors d
    where d.id = p_door_id;

    -- Get zone each side of the door
    if (p_door_side = 'A') then
      set l_door_current_zone = l_side_a_zone_id;
      set l_door_new_zone     = l_side_b_zone_id;
    elseif (p_door_side = 'B') then
      set l_door_current_zone = l_side_b_zone_id;
      set l_door_new_zone     = l_side_a_zone_id;
    else
      -- We've been passed an invalid door side. This shouldn't ever happen...
      set p_access_denied = 98;
      leave main;
    end if;

    set p_new_zone_id = l_door_new_zone;

    -- We must always have a new zone ID for permission checking to work
    if (l_door_new_zone is null) then
      set p_access_denied = 97;
      leave main;
    end if;

    -- zone_id = 0 is special - it means either off-site/outside (i.e. door is an exit).
    -- Always allow access.
    if (l_door_new_zone = 0) then
      set p_access_denied = 0;
      leave main;
    end if;

    -- Get permission code of zone
    select z.permission_code
    into l_permission_code
    from zones z
    where z.id = l_door_new_zone;

    -- Banned members get a special banned message, and can't open the door even if they 
    -- somehow end up with the permission via another role
    if
    (
      select count(*)
      from role_user ru
      inner join roles r on ru.role_id = r.id
      where r.name = 'member.banned'
        and ru.user_id = p_member_id
    ) > 0 then 
      set p_access_denied = 4; -- "Access Denied: Banned Member"
      leave main;
    end if;

    -- Check the member has permission to enter the requested zone
    select fn_check_permission(p_member_id, l_permission_code)
    into l_access_granted;

    if (l_access_granted = 0) then
      -- We know the user doesn't have permission to enter the zone. But lets 
      -- check if they're an ex-member. If so, return a slightly different
      -- access denied message rather than the generic one.
      if
      (
        select count(*)
        from role_user ru
        inner join roles r on ru.role_id = r.id
        where r.name = 'member.ex'
          and ru.user_id = p_member_id
      ) > 0 then 
        set p_access_denied = 1; -- "Access Denied: Ex-member"
      else
        set p_access_denied = 2; -- "Access Denied"
      end if;

      leave main;
    else
      set p_access_denied = 0; -- Access granted.
      leave main;
    end if;

  end main;

  if (p_access_denied != 0) then
    -- Vary the message depending on the reason
    if (p_access_denied = 1) then
      set p_err = "Not a current member";
      set p_display_msg = "Access Denied: Ex-member";
    elseif (p_access_denied = 2) then
      set p_err = "No permission to open door";
      set p_display_msg = "Access Denied";
    elseif (p_access_denied = 4) then
      set p_err = "Banned member (has member.banned role)";
      set p_display_msg = "Access Denied: Banned Member";
    else 
      -- Some other reason, send non-specific Access Denied
      set p_err = "Access Denied (other)";
      set p_display_msg = concat("Access Denied:", convert(p_access_denied, char));
    end if;
  end if;


END //
DELIMITER ;
