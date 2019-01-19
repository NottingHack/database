drop procedure if exists sp_log_event;

DELIMITER //
CREATE PROCEDURE sp_log_event
(
  IN p_event_type   varchar(25),
  IN p_event_value  varchar(256)
)
SQL SECURITY DEFINER
BEGIN

  insert into events (type, value)
  values (p_event_type, p_event_value);

END //
DELIMITER ;

