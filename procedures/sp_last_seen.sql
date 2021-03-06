drop procedure if exists sp_last_seen;
/* err is null on success */
DELIMITER //
CREATE PROCEDURE sp_last_seen
(
   IN p_member_id  int,
   OUT last_seen varchar(100)
)
SQL SECURITY DEFINER
BEGIN

  declare days varchar(4);
  declare mhs varchar(50);
  declare rowc int;

  -- Temporarily set time zone to UTC as l.access_time is UTC but unix_timestamp() would cause SYSTEM tz to be applied during the conversion
  SET @oldTZ := @@time_zone;
  SET @@time_zone := '+00:00';

  select
    floor((unix_timestamp() - unix_timestamp(l.access_time)) / 86400) as days,
    time_format(sec_to_time( (unix_timestamp() - unix_timestamp(l.access_time)) - (floor((unix_timestamp() - unix_timestamp(l.access_time)) / 86400)*24*60*60)  ), "%Hh %im %Ss") as mhs
  into
    days,
    mhs
  from user u
  inner join access_logs l on l.user_id = u.id
  where u.id = p_member_id
  order by access_time desc
  limit 1;

  SET @@time_zone := @oldTZ;

  if (days > 0) then
    set last_seen = concat(days, "d ");
  else
    set last_seen = "";
  end if;

  set last_seen = concat(last_seen, mhs);
  if (last_seen is null) then
    set last_seen = "";
  end if;

END //
DELIMITER ;
