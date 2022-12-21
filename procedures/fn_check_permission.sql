drop function if exists fn_check_permission;

/*
  Check if member_id has been assigned permission_code.
  Returns 1 if yes, 0 if no
 */


DELIMITER //
CREATE FUNCTION fn_check_permission
(
    member_id int,
    permission_desc varchar(255)
)
returns int
DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
BEGIN

  declare c int;
  set c = 0;

  select count(*)
  into c
  from user u
  inner join role_user ru on ru.user_id = u.id
  inner join roles r on r.id = ru.role_id
  inner join permission_role pr on pr.role_id = r.id
  inner join permissions p on p.id = pr.permission_id
  where u.id = member_id
    and lower(p.name) = lower(permission_desc);

  if (c >= 1) then
    set c = 1;
  else
    set c = 0;
  end if;
  
  return c;

END //
DELIMITER ;
