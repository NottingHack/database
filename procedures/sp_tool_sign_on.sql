drop procedure if exists sp_tool_sign_on;

DELIMITER //
CREATE PROCEDURE sp_tool_sign_on
(
   IN  p_tool_name      varchar(20),
   IN  p_rfid_serial    varchar(50),
   OUT p_access_result  int,
   OUT p_msg            varchar(200),
   OUT p_member_id      int
)
SQL SECURITY DEFINER
BEGIN
  declare cnt int;
  declare l_tool_id int;
  declare username varchar(50);
  declare member_status int;
  declare tool_restrictions varchar(20);
  declare tool_status varchar(20);
  declare access_level varchar(1);
  declare tool_pph int;
  declare credit_limit int;
  declare balance int;
  declare permission_tool_use    int;
  declare permission_purchase    int;
  declare permission_credit_only int;

  set p_access_result = 0;
  set p_msg = '';

  main: begin

    -- Check tool name is actaully known
    select count(*)
    into cnt
    from tools t
    where t.name = p_tool_name;

    if (cnt = 0) then
      set p_msg = 'Tool not conf.  ';
    leave main;
    elseif (cnt > 1) then
      set p_msg = 'Tool conf error';
      leave main;
    end if;

    -- Get details
    select
      t.id,
      t.restrictions,
      t.status,
      t.pph
    into
      l_tool_id,
      tool_restrictions,
      tool_status,
      tool_pph
    from tools t
    where t.name = p_tool_name;

    -- Check RFID serial is known
    select count(*)
    into cnt
    from user u
    inner join profile p on p.user_id = u.id
    inner join rfid_tags r on u.id = r.user_id
    where r.rfid_serial = p_rfid_serial
      and r.state = 10; -- Active

    if (cnt = 0) then
      set p_msg = 'Unknown card    ';
      leave main;
    elseif (cnt > 1) then -- Error out if multiple active entries for the same RFID card 
      set p_msg = 'Card conf error ';
      leave main;
    end if;

    -- Get member details from card
    select 
      u.username,
      u.id,
      p.balance,
      p.credit_limit
    into 
      username,
      p_member_id,
      balance,
      credit_limit
    from user u
    inner join profile p on p.user_id = u.id
    inner join rfid_tags r on r.user_id = u.id
    where r.rfid_serial = p_rfid_serial
      and r.state = 10; -- Active

    -- Check member has permission to use any tool (should be all current members)
    if (fn_check_permission(p_member_id, 'tools.use') = 0) then
      set p_msg = 'No permission   ';
      leave main;
    end if;

    -- Only allow tool to be used by maintainer if disabled, or in a maintenance slot
    if ((tool_status = 'DISABLED') or (fn_tool_in_maintenance_slot(l_tool_id) = 1)) then
      if (fn_check_permission(p_member_id, concat('tools.', replace(p_tool_name, ' ', ''), '.maintain')) = 1) then
        -- tool use by a maintainer whist disabled or in a maintenance slot is free
        set tool_pph = 0;
      else
        -- not a maintainer - disallow signon
        set p_msg = 'Out of service';
        leave main;
      end if;
    end if;

    -- get purchase permissions
    select
      fn_check_permission(p_member_id, 'snackspace.purchase'),
      fn_check_permission(p_member_id, 'snackspace.purchase.creditOnly')
    into
      permission_purchase,
      permission_credit_only;

    -- If a charge applies for using the tool, check the member has some credit
    if (tool_pph > 0) then
      if not
      (
        (permission_purchase    = 1 and balance > -1*credit_limit) or -- permission to go into snackspace debt and not over credit limit, or
        (permission_credit_only = 1 and balance > 0)               or -- permission to use snackspace only if in credit, or
        (                                                             -- pledged time remaing
          (
            select ifnull(sum(tu.duration), 0) -- get the total pledged time remaining (e.g. -60 here means 1min of pledged time left)
            from tool_usages tu
            where tu.user_id = p_member_id
              and tu.tool_id = l_tool_id
              and tu.status = 'COMPLETE'
          ) < 0
        )
      ) then
        -- No credit and no pledged time remaing.

        if (permission_purchase = 0 and permission_credit_only = 0) then
          -- User has the generic 'tools.use' permission, but no a permission to use snackspace credit of any kind. This should be very unusual.
          -- Want a slightly different message to tell if this is happening
          set p_msg = 'Not permitted';
        else
          set p_msg = 'Out of credit';
        end if;
        leave main;
      end if;
    end if; -- if (tool_pph > 0) then


    -- If the tool isn't restircted, grant access now
    if (tool_restrictions = 'UNRESTRICTED') then
      set p_access_result = 1;
      set p_msg = 'U'; -- User.
      leave main;
    end if;

    -- Tool is restricted, so check member has been inducted and/or is a maintainer
    if (fn_check_permission(p_member_id, concat('tools.', replace(p_tool_name, ' ', ''), '.maintain')) = 1) then
      set access_level = 'M';
    elseif (fn_check_permission(p_member_id, concat('tools.', replace(p_tool_name, ' ', ''), '.induct')) = 1) then
      set access_level = 'I';
    elseif (fn_check_permission(p_member_id, concat('tools.', replace(p_tool_name, ' ', ''), '.use')) = 1) then
      set access_level = 'U';
    else
      set p_msg = 'Not inducted';
      leave main;
    end if;

    -- Ok, now grant access
    set p_msg = access_level;
    set p_access_result = 1;

  end main;

  -- Add use entry
  if (p_access_result = 1) then
    insert into tool_usages (user_id    , tool_id  , start    , status       )
                     values (p_member_id, l_tool_id, UTC_TIMESTAMP(), 'IN_PROGRESS');

    -- Update tool status to in use
    update tools
    set status = 'IN_USE'
    where tools.id = l_tool_id
      and tools.status != 'DISABLED';
  end if;

END //
DELIMITER ;
