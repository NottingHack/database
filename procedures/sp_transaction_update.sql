drop procedure if exists sp_transaction_update;

/*
 * Update a pending transaction in the transactions table. Don't allow update
 * if transaction state is already completed/aborted.
 * If updating to COMPLETED status, also update member.balance.
 */

DELIMITER //
CREATE PROCEDURE sp_transaction_update
(
  IN  p_tran_id     int,
  IN  p_tran_status varchar(  8),
  IN  p_tran_desc   varchar(512),
  OUT p_err         varchar(100)
)
SQL SECURITY DEFINER
BEGIN
  declare ck_exists int;
  declare amount int;
  declare memberid int;
  declare process_err varchar(100);
  set p_err = '';
  
  if ((p_tran_desc is not null) and (length(p_tran_desc)=0)) then
    set p_tran_desc = null;
  end if;

  main: begin

    -- If the transaction is already at status 'COMPLETE', don't allow it to be changed
    select count(*) into ck_exists
    from transactions t
    where t.id = p_tran_id
      and t.transaction_status in ('COMPLETE', 'ABORTED');

    if (ck_exists > 0) then
      set p_err = 'Transaction is already complete or aborted - can''t amend!';
      leave main;
    end if;

    -- Check the transaction id can be found
    select count(*) into ck_exists
    from transactions t
    where t.id = p_tran_id;

    if (ck_exists != 1) then
      set p_err = 'Unable to find transaction details';
      leave main;
    end if;

    -- If setting the transaction to COMPLETE, update member balance as well.
    if (p_tran_status = 'COMPLETE') then
    begin
      declare EXIT HANDLER for SQLEXCEPTION, SQLWARNING
      begin
        GET DIAGNOSTICS CONDITION 1 @text = MESSAGE_TEXT;
        set p_err = concat('Error - transaction rollback!: ', @text);
        rollback;
      end;

      start transaction;

      select t.amount, t.user_id
      into amount, memberid
      from transactions t
      where t.id = p_tran_id;

      update transactions t
      set 
        t.transaction_status = p_tran_status,
        t.transaction_desc = ifnull(p_tran_desc, t.transaction_desc) -- if a new desc isn't given, keep the old one.
      where t.id = p_tran_id;

      update profile p
      set p.balance = p.balance + amount
      where p.user_id = memberid;

      call sp_process_transaction(p_tran_id, process_err);

      commit;
    end;
    else
      -- Not updating to COMPLETE, so just update details, not balance.
      update transactions t
      set
        t.transaction_status = p_tran_status,
        t.transaction_desc = ifnull(p_tran_desc, t.transaction_desc) -- if a new desc isn't given, keep the old one.
      where id = p_tran_id;
    end if;


  end main;

END //
DELIMITER ;
