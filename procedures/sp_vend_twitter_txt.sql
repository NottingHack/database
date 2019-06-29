drop procedure if exists sp_vend_twitter_txt;

/*
  Take a transaction id that relates to a sucsessfull vend, and return a tweet (or blank
  string if not enough data)
*/

DELIMITER //
CREATE PROCEDURE sp_vend_twitter_txt
(
   IN  p_vend_tran_id varchar(  6),
   OUT p_tweet        varchar(140)
)
SQL SECURITY DEFINER
BEGIN

  declare continue HANDLER for SQLWARNING begin end;

  main: begin

    set p_tweet = "";
    select concat(m.username, ' purchased a ', p.short_description, ' from the vending machine')
    into p_tweet
    from vend_logs vl
    inner join vending_locations vr on vr.encoding = vl.position
    inner join products p on p.id = vr.product_id
    inner join user m on m.id = vl.user_id
    inner join vending_machines vd on vd.id = vl.vending_machine_id
    where vl.id = p_vend_tran_id
      and vd.type = 'VEND'; -- Don't want tweets for payments

  end main;

END //
DELIMITER ;
