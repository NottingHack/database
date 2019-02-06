drop procedure if exists sp_transaction_log;

/*
 * Log a transaction in transactions table. If tran_status is "COMPLETE", also update members.balance.
 */

DELIMITER //
CREATE PROCEDURE sp_transaction_log
(
   IN  p_member_id    int,
   IN  p_amount       int,
   IN  p_tran_type    varchar(6),
   IN  p_tran_status  varchar(8),
   IN  p_tran_desc    varchar(512),
   IN  p_recorded_by  int,
   OUT p_tran_id      int,
   OUT p_err          varchar(100)
)
SQL SECURITY DEFINER
BEGIN
  declare member_exists int;
  declare process_err varchar(100);
  set member_exists = 0;
  set p_err = '';

  main: begin

    declare EXIT HANDLER for SQLEXCEPTION, SQLWARNING
    begin
      set p_err = 'Error - transaction rollback!';
      rollback;
    end;

    -- check p_member_id is valid
    select count(*) into member_exists
    from user u
    inner join profile p on u.id = p.user_id
    where u.id = p_member_id;

    if (member_exists != 1) then
      set p_err = "Invalid member_id";
      leave main;
    end if;

    if (p_tran_status not in ('COMPLETE', 'PENDING')) then
      set p_err = 'Error - invalid status';
      leave main;
    end if;

    start transaction;

    insert into transactions (user_id, amount, transaction_type, transaction_status, transaction_desc, recorded_by, transaction_datetime)
    values (p_member_id, p_amount, p_tran_type, p_tran_status, p_tran_desc, p_recorded_by, sysdate());

    set p_tran_id = last_insert_id();

    if (p_tran_status = 'COMPLETE') then
      update profile p
      set p.balance = p.balance + p_amount
      where p.user_id = p_member_id;

      call sp_process_transaction(p_tran_id, process_err);

    end if;

    commit;
  end main;

END //
DELIMITER ;
