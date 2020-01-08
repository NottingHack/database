CREATE VIEW `vw_payment` AS
SELECT
  u.username AS username,
  u.id AS user_id,
  t.transaction_datetime AS transaction_datetime,
  t.id AS transaction_id,
  t.amount AS amount,
  t.transaction_desc AS transaction_desc,
  (SELECT
      IFNULL(SUM(pp.amount), 0)
    FROM (purchase_payment pp
      JOIN transactions t2 ON (t2.id = pp.transaction_id_purchase))
    WHERE ((pp.transaction_id_payment = t.id) AND (t2.transaction_type = 'VEND'))
  ) AS for_vend,
  (SELECT
      IFNULL(SUM(pp.amount), 0)
    FROM (purchase_payment pp
      JOIN transactions t2 ON (t2.id = pp.transaction_id_purchase))
    WHERE ((pp.transaction_id_payment = t.id) AND (t2.transaction_type = 'TOOL'))
  ) AS for_tool,
  (SELECT
      IFNULL(SUM(pp.amount), 0)
    FROM (purchase_payment pp
      JOIN transactions t2 ON (t2.id = pp.transaction_id_purchase))
    WHERE ((pp.transaction_id_payment = t.id) AND (t2.transaction_type = 'BOX'))
  ) AS for_box,
  (SELECT
      IFNULL(SUM(pp.amount), 0)
    FROM (purchase_payment pp
      JOIN transactions t2 ON (t2.id = pp.transaction_id_purchase))
    WHERE ((pp.transaction_id_payment = t.id) AND (t2.transaction_type NOT IN ('TOOL', 'VEND', 'BOX')))
  ) AS for_other
FROM (transactions t
  JOIN user u ON (u.id = t.user_id))
WHERE (t.amount > 0);
