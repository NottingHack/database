drop procedure if exists sp_vend_success;

/*
  Vending machine has confirmed the vend was succesfull. Update vend_log with the datetime & item position,
  update the transactions table to show it's complete, and update the members balance.

*/

DELIMITER //
CREATE PROCEDURE sp_vend_success
(
   IN  p_rfid_serial  varchar( 50),
   IN  p_vend_tran_id varchar(  6),
   IN  p_pos          varchar( 10),
   OUT p_err          varchar(100)
)
SQL SECURITY DEFINER
BEGIN
  declare ck_exists  int;
  declare tran_id    int;
  declare vdesc      varchar(100);
  
  declare location   varchar(10);
  declare price      int;
  declare prddesc    varchar(25);
  declare prdid      int;
  declare vm_id      int;
  declare vm_type    varchar(10);

  set p_err = '';

  main: begin  

    -- Check the transaction id & serial id match up with an active vend entry
    select count(*) into ck_exists
    from vend_logs v
    where v.id = p_vend_tran_id
      and v.rfid_serial = p_rfid_serial
      and v.cancelled_time is null
      and v.transaction_id is not null
      and v.position is null;

    if (ck_exists = 0) then
      set p_err = 'unable to find matching entry in vend_log (BUG)';
      leave main;
    end if;

    select
      v.transaction_id,
      v.vending_machine_id,
      m.type
    into
      tran_id,
      vm_id,
      vm_type
    from vend_logs v
    inner join vending_machines m on m.id = v.vending_machine_id
    where v.id = p_vend_tran_id;

    if (vm_type = 'NOTE') then
      -- Payment made using note acceptor

      select concat('Cash payment - £', format(abs(v.amount_scaled)/100, 2))
      into vdesc
      from vend_logs v
      where v.id = p_vend_tran_id;
    else
      -- vending machine
      select count(*) into ck_exists
      from vending_locations vl
      where vl.encoding = p_pos
        and vl.vending_machine_id = vm_id;

      if (ck_exists = 0) then
        -- We don't recognise the location the vmc just vended from!
        -- Continue to record the vend, but log a warning in the events table
        call sp_log_event('WARN', 'VEND: Unknown VMC location reported');
        set location = 'Unknown';
        set prddesc = 'Unknown item';
      else
        -- Get product details - if known; but still record vend if not filled in.
        select vl.name, p.id, p.price, coalesce(p.short_description, 'Unknown item') 
        into location, prdid, price, prddesc
        from vending_locations vl
        left outer join products p on vl.product_id = p.id
        where vl.encoding = p_pos
          and vl.vending_machine_id = vm_id;
      end if;

      set vdesc = concat('[', prddesc, '] vended from location [', location, '].');
    end if; -- if vending machine

    call sp_transaction_update(tran_id, 'COMPLETE', vdesc, p_err);
    if (length(p_err) > 0) then
      leave main;
    end if;

    update transactions
    set product_id = prdid
    where id = tran_id;

    update vend_logs
    set success_time = UTC_TIMESTAMP(), position = p_pos
    where vend_logs.id = p_vend_tran_id;

  end main;


END //
DELIMITER ;

