drop procedure if exists sp_vend_check_rfid;

/*
  Check an RFID card is known, and linked to an active member.
  Return a vend transaction id if it is, or p_tran_id=0 if the 
  card isn't valid (and set @p_err with the reject reason)  
*/

DELIMITER //
CREATE PROCEDURE sp_vend_check_rfid
(
   IN  p_vmc_id       int,
   IN  p_rfid_serial  varchar(50),
   OUT p_tran_id      varchar(6),
   OUT p_err          varchar(100)
)
SQL SECURITY DEFINER
BEGIN
  declare ck_exists int;
  declare access_granted int;
  declare r_state int;
  declare member_id int;

  set p_tran_id = '0';

  main: begin
    set access_granted = 0;
    set p_rfid_serial = rtrim(p_rfid_serial);

    -- First, check the card is suitable (not unknown type)
    if (p_rfid_serial = 'Unknown Card Type') then
      set p_err = 'Unknown Card Type';
      set p_tran_id= '0';
      leave main;
    end if;

    -- See if the serial is known
    select count(*) into ck_exists
    from user u
    inner join rfid_tags r on r.user_id = u.id
    where r.rfid_serial = p_rfid_serial;

    if (ck_exists = 0) then
      set p_err = "RFID serial not found";
      set p_tran_id= '0';
      leave main;
    end if;

    select
      u.id,
      r.state
    into
      member_id,
      r_state
    from user u
    inner join rfid_tags r on r.user_id = u.id
    where r.rfid_serial = p_rfid_serial
    order by state limit 1;

    if (r_state != 10) then -- STATE_ACTIVE
      set p_err = "RFID serial not active";
      set p_tran_id= '0';
      leave main;
    end if;

    insert into vend_logs (vending_machine_id, rfid_serial, user_id, enqueued_time)
    values (p_vmc_id, p_rfid_serial, member_id, UTC_TIMESTAMP());

    set p_tran_id = last_insert_id();

  end main;

  commit;

END //
DELIMITER ;

