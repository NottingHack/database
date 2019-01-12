drop procedure if exists sp_get_member_name;

DELIMITER //
CREATE PROCEDURE sp_get_member_name
(
  IN handle varchar(100),
  OUT name varchar(100),
  OUT id int()
)
SQL SECURITY DEFINER
BEGIN

  select 
    concat(firsname, ," ", surname) as fullname
  into
    name, 
    member_id
  from members 
  where username = handle;

END //
DELIMITER ;