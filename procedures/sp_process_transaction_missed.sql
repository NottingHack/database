drop procedure if exists sp_process_transaction_missed;



DELIMITER //
CREATE PROCEDURE sp_process_transaction_missed
(
   IN  p_member_id      int
)
SQL SECURITY DEFINER
BEGIN

  declare v_transaction_id int;
  declare v_err            varchar(100);
  declare done int default false;
  
  declare transactions_cur cursor for
      select 
        t.transaction_id
      from transactions t
      where (t.member_id = p_member_id or p_member_id = -1)
        and t.transaction_id not in (select pp1.transaction_id_purchase from purchase_payment pp1)
        and t.transaction_id not in (select pp2.transaction_id_payment  from purchase_payment pp2)
      order by t.transaction_id;

  declare continue handler for not found set done = TRUE;
  

  main: begin  

    open transactions_cur;
    
    read_loop: LOOP
      fetch transactions_cur into v_transaction_id;


      if done then 
        leave read_loop;
      end if;

      call sp_process_transaction(v_transaction_id, v_err);

    end loop; 

  end main;
  

END //
DELIMITER ;
