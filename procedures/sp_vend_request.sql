drop procedure if exists sp_vend_request;

/*
 * Respond to VREQ messages from vending machine. Check rfid & tran id match up with an entry in vend_log.
 * Check the members.balance+credit_limit covers the requested amout.
 * If allowed (p_result=1), also create a pending entry in the transactions table (as the 
 * vending machine should start vending on receipt of a successful p_result).
 * 
 * Note on p_err: This should be <= 16 characters as it sent to the LCD on failure
 */

DELIMITER //
CREATE PROCEDURE sp_vend_request
(
   IN  p_rfid_serial  varchar(50),
   IN  p_vend_tran_id varchar(6),
   IN  p_amount       int,
   OUT p_err          varchar(100),
   OUT p_result       int
)
SQL SECURITY DEFINER
BEGIN
  declare ck_exists int;
  declare r_state   int;
  declare member_id int;
  declare balance   int;
  declare climit    int;
  declare tran_id   int;
  declare permission_purchase    int;
  declare permission_credit_only int;
  declare permission_payment     int;
  declare permission_debt_only   int;
  declare vend_permitted int;

  set p_result = 0;
  set p_err = '';

  main: begin

    -- Check the transaction id & serial id match up with an active vend entry
    select count(*) into ck_exists
    from vend_logs v
    where v.id = p_vend_tran_id
      and v.rfid_serial = p_rfid_serial
      and v.request_time is null
      and v.cancelled_time is null
      and v.transaction_id is null;

    if (ck_exists = 0) then
      set p_err = 'VR01 failed'; -- unable to find matching entry in vend_log (BUG?) 
      leave main;
    end if;

    -- check member_id is still active, get balance and credit limit
    select
      u.id,
      p.balance,
      p.credit_limit,
      r.state
    into
      member_id,
      balance,
      climit,
      r_state
    from user u
    inner join profile p on p.user_id = u.id
    inner join rfid_tags r on r.user_id = u.id
    where r.rfid_serial = p_rfid_serial
    order by state limit 1
    for update;

    if (member_id is null) then
      set p_err = 'VR05 Int. error'; -- unable to match the rfid_serial/vend_tran_id to a user. Should never happen...
      update vend_logs
      set request_time = UTC_TIMESTAMP(), denied_reason = p_err, amount_scaled = p_amount
      where vend_logs.id = p_vend_tran_id;
      leave main;
    end if;

    if (r_state != 10) then -- STATE_ACTIVE
      set p_err = 'VR02 Not active'; -- 'RFID serial not active';
      update vend_logs
      set request_time = UTC_TIMESTAMP(), denied_reason = p_err, amount_scaled = p_amount
      where vend_logs.id = p_vend_tran_id;
      leave main;
    end if;

    -- check the member_id matches that in the vend_log
    select count(*) into ck_exists
    from vend_logs v
    where v.id = p_vend_tran_id
      and v.rfid_serial = p_rfid_serial
      and v.user_id = member_id;

    if (ck_exists != 1) then
      set p_err = 'VR03 int error '; -- Member ID / rfid / tran_id mismatch (BUG?)';
      update vend_logs
      set request_time = UTC_TIMESTAMP(), denied_reason = p_err, amount_scaled = p_amount
      where vend_logs.id = p_vend_tran_id;
      leave main;
    end if;

    -- get relevant permissions
    select
      fn_check_permission(member_id, 'snackspace.purchase'),
      fn_check_permission(member_id, 'snackspace.purchase.creditOnly'),
      fn_check_permission(member_id, 'snackspace.payment'),
      fn_check_permission(member_id, 'snackspace.payment.debtOnly')
    into
      permission_purchase,
      permission_credit_only,
      permission_payment,
      permission_debt_only;

    -- No 'snackspace.purchase' permission = zero credit limit
    if (permission_purchase = 0) then
      set climit = 0;
    end if;

    -- Permission checking, see https://github.com/NottingHack/hms2/issues/359
    -- TODO: Check/sum pending transactions
    set vend_permitted = 0;
    set p_err = 'Unknown.';
    if (p_amount > 0) then
      -- purchase
      if ((permission_purchase = 0) and (permission_credit_only = 0)) then
        -- No relevant permission of any kind. Should be unusual?
        set vend_permitted = 0;
        set p_err = 'Unavailable.';
      elseif (balance-p_amount >= -climit) then
        -- Purchase won't cause credit limit to be exceeded
        set vend_permitted = 1;
      else
        -- Purchase will cause credit limit to be exceeded
        set vend_permitted = 0;
        set p_err = 'Out of credit';
      end if;
    else
      -- payment
      if (permission_payment = 1) then
        set vend_permitted = 1;
      elseif (permission_debt_only = 1) then
        if (balance >= 0) then
          -- has 'snackspace.payment.debtOnly' permission, but not in debt...
          set vend_permitted = 0;
          set p_err = 'Not in Debt';
        else
          set vend_permitted = 1;
        end if;
      else
        -- no relevant permission
        set p_err = 'Unavailable.';
        set vend_permitted = 0;
      end if;
    end if;

    if (vend_permitted = 1) then
      -- create in-progress transaction
      set tran_id = 0;
      call sp_transaction_log (member_id, (-1*p_amount), 'VEND', 'PENDING', 'Vend in progress', null, tran_id, p_err);

      if (p_err != '') then
        leave main;
      end if;

      update vend_logs
      set request_time = UTC_TIMESTAMP(), amount_scaled = p_amount, transaction_id = tran_id
      where id = p_vend_tran_id;

      set p_result = 1;
    else
      -- mark as denied
      update vend_logs
      set request_time = UTC_TIMESTAMP(), denied_reason = p_err, amount_scaled = p_amount
      where vend_logs.id = p_vend_tran_id;
      leave main;
    end if;
  end main;


END //
DELIMITER ;
