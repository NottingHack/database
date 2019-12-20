CREATE VIEW `vw_snackspace_monthly` AS
SELECT
  YEAR(l.success_time) AS Year,
  MONTHNAME(l.success_time) AS Month,
  COUNT(*) AS "Items vended",
  COUNT(IF(l.vending_machine_id = 1, 1, NULL)) AS "Snacks Vended",
  COUNT(IF(l.vending_machine_id = 4, 1, NULL)) AS "Drinks Vended",
  CONCAT('£', CAST((SUM(l.amount_scaled)/100) AS DECIMAL(20,2))) AS "Vend value",
  CONCAT('£', CAST((AVG(l.amount_scaled)/100) AS DECIMAL(20,2))) AS "Avg item cost",
  (
    SELECT CONCAT('£', CAST((SUM(-1*t.amount)/100) AS DECIMAL(20,2)))
    FROM transactions t
    WHERE YEAR(l.success_time) = YEAR(t.transaction_datetime)
      AND MONTH(l.success_time) = MONTH(t.transaction_datetime)
      AND t.transaction_status = 'COMPLETE'
      AND t.transaction_type = 'TOOL'
  ) AS "Laser charges",
  (
    SELECT CONCAT('£', CAST((SUM(t.amount)/100) AS DECIMAL(20,2)))
    FROM transactions t
    WHERE YEAR(l.success_time) = YEAR(t.transaction_datetime)
      AND MONTH(l.success_time) = MONTH(t.transaction_datetime)
      AND t.amount > 0
      AND t.transaction_status = 'COMPLETE'
  ) AS "Payments"
FROM vend_logs l
WHERE (l.vending_machine_id IN (1, 4) OR l.vending_machine_id IS NULL)
  AND l.success_time IS NOT NULL
  AND (YEAR(l.success_time) > 2012 OR (YEAR(l.success_time)=2012 AND MONTH(l.success_time) >= 6))
GROUP BY YEAR(l.success_time), MONTHNAME(l.success_time)
ORDER BY YEAR(l.success_time) DESC, MONTH(l.success_time) DESC;
