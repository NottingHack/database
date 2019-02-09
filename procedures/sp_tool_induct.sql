drop procedure if exists sp_tool_induct;

/* Recorded member with card <p_card_inductee> as having been inducted on <p_tool_name> by member with card <p_card_inductee>.
 * p_ret = 0 on success, non-zero on failure
 * p_msg = mesage to show on LCD (only first 16 characters appear on display) */

DELIMITER //
CREATE PROCEDURE sp_tool_induct
(
   IN  p_tool_name       varchar( 20),
   IN  p_card_inductor   varchar( 50),
   IN  p_card_inductee   varchar( 50),
   OUT p_ret             int,
   OUT p_msg             varchar(200)
)
SQL SECURITY DEFINER
BEGIN
  declare cnt int;
  declare l_inductor_id int;
  declare l_inductee_id int;
  declare tool_id int;

  declare EXIT HANDLER for SQLEXCEPTION, SQLWARNING
  begin
    GET DIAGNOSTICS CONDITION 1 @text = MESSAGE_TEXT;
    -- note that only the first 16 characters of the error appears in the tool LCD. But all of it ends up in the log.
    set p_msg = concat('Failed: int err. Error - transaction rollback!: ', @text);
    rollback;
  end;

  set p_msg = '';
  set p_ret = -1;

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

  -- Get tool id
    select t.id
    into tool_id
    from tools t
    where t.name = p_tool_name;

    -- Check <p_card_inductor> is actaully listed as being able to give inductions, and get details if so
    select count(*)
    into cnt
    from rfid_tags r
    where r.rfid_serial = p_card_inductor
      and r.state = 10
      and (fn_check_permission(r.user_id, concat('tools.', replace(p_tool_name, ' ', ''), '.induct')) = 1);

    if (cnt <= 0) then
      set p_msg = 'Access denied    (NI)';
      leave main;
    end if;

    -- Get member id of inductor
    select r.id
    into l_inductor_id
    from rfid_tags r
    where r.rfid_serial = p_card_inductor
      and r.state = 10;

    -- check <p_card_inductee> relates to a member with the generic "tools.use" permission
    select count(*)
    into cnt
    from user u
    inner join rfid_tags r on u.id = r.user_id
    where r.rfid_serial = p_card_inductee
      and r.state = 10
      and (fn_check_permission(u.id, 'tools.use') = 1);

    if (cnt <= 0) then
      set p_msg = 'Bad card/No perm.';
      leave main;
    end if;

    -- Check if inductee has already been inducted.. and just return success if so
    select count(*)
    into cnt
    from user u
    inner join rfid_tags r on u.id = r.user_id
    where r.rfid_serial = p_card_inductee
      and r.state = 10
      and (fn_check_permission(r.user_id, concat('tools.', replace(p_tool_name, ' ', ''), '.use')) = 1);

    if (cnt > 0) then
      set p_msg = 'Already inducted';
      set p_ret = 0;
      leave main;
    end if;

    -- Get member id of inductee
    select u.id
    into l_inductee_id
    from user u
    inner join rfid_tags r on r.user_id = u.id
    where r.rfid_serial = p_card_inductee
      and r.state = 10;

    start transaction;

    -- Give user being inducted the "user" role for the tool
    insert into role_user (user_id, role_id)
    select l_inductee_id, r.id
    from roles r
    where r. name = concat('tools.', replace(p_tool_name, ' ', ''), '.user');

    -- expecting exactly 1 row inserted
    set cnt = ROW_COUNT();
    if (cnt != 1) then
      set p_msg = concat('Failed: int err. Error - unexpected number of rows inserted into role_user: ', convert(cnt,char));
      rollback;
      leave main;
    end if;

    -- Log who inducted the user
    insert into role_updates (user_id, added_role_id, created_at, update_by_user_id)
    select l_inductee_id, r.id, sysdate(), l_inductor_id
    from roles r
    where r. name = concat('tools.', replace(p_tool_name, ' ', ''), '.user');

    -- expecting exactly 1 row inserted
    set cnt = ROW_COUNT();
    if (cnt != 1) then
      set p_msg = concat('Failed: int err. Error - unexpected number of rows inserted into role_updates: ', convert(cnt,char));
      rollback;
      leave main;
    end if;

    commit;

    set p_ret = 0;

  end main;

END //
DELIMITER ;
