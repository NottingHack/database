drop procedure if exists sp_web_set_vendprd;

/*


*/

DELIMITER //
CREATE PROCEDURE sp_web_set_vendprd
(
   IN   p_member_id   int,
   IN   p_vmc_ref_id  int,
   IN   p_product_id  int,
   OUT  p_err         varchar(255)
)
SQL SECURITY DEFINER
BEGIN
  declare ck_exists      int;

  set ck_exists = 0;
  set p_err = '';

  main: begin

    -- TODO: p_member_id/permissions check

    select count(*) into ck_exists
    from vending_locations vl
    where vl.id = p_vmc_ref_id;

    if (ck_exists != 1) then
      set p_err = 'Failed to find location';
      leave main;
    end if;

    if (p_product_id = -1) then
      delete from product_vending_location
      where vending_location_id = p_vmc_ref_id;

      leave main;
    end if;

    select count(*) into ck_exists
    from products p
    where p.id = p_product_id;

    if (ck_exists != 1) then
      set p_err = 'Failed to find product';
      leave main;
    end if;


    replace into product_vending_location (vending_location_id, product_id) values (p_vmc_ref_id, p_product_id);

  end main;

END //
DELIMITER ;
