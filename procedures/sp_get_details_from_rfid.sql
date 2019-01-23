drop procedure if exists sp_get_details_from_rfid;

/*
  Lookup handle and balance from RFID serial - used after
  card is first presented to vending machine
*/

DELIMITER //
CREATE PROCEDURE sp_get_details_from_rfid
(
   IN  p_rfid_serial  varchar(50),
   OUT p_username     varchar(100),
   OUT p_balance      int,
   OUT p_err          varchar(100)
)
SQL SECURITY DEFINER
BEGIN
  declare ck_exists int;
  declare member_id int;

  main: begin
    set p_rfid_serial = rtrim(p_rfid_serial);

    -- See if the serial is known
    select count(*) into ck_exists
    from user u
    inner join rfid_tags r on r.user_id = u.id
    where r.rfid_serial = p_rfid_serial;

    if (ck_exists = 0) then
      set p_err = "RFID serial not found";
      leave main;
    end if;

    select
      u.username,
      p.balance
    into
      p_username,
      p_balance
    from user u
    inner join profile p on p.user_id = u.id
    inner join rfid_tags r on r.user_id = u.id
    where r.state = 10 -- STATE_ACTIVE
      and r.rfid_serial = p_rfid_serial
    order by state limit 1;

  end main;

END //
DELIMITER ;
