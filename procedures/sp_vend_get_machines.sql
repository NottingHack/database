drop procedure if exists sp_vend_get_machines;

/*
  Get details of all known vending machines
*/

DELIMITER //
CREATE PROCEDURE sp_vend_get_machines
(
   IN  p_vmc_id int
)
SQL SECURITY DEFINER
BEGIN
  declare ck_exists int;
  declare tran_id   int;
  main: begin

  select
    vd.id          as vmc_id,
    vd.description as vmc_description,
    vd.type        as vmc_type,
    vd.connection  as vmc_connection,
    vd.address     as vmc_address
  from vending_machines vd
  where vd.id = p_vmc_id or p_vmc_id = -1;

  end main;


END //
DELIMITER ;
