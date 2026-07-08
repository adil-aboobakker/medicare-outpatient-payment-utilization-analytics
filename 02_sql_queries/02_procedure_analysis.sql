SELECT
  apc,
  AVG(average_total_payments) AS avg_procedure_payment
FROM 
  bigquery-public-data.cms_medicare.outpatient_charges_2015
GROUP BY
  apc
ORDER BY
  avg_procedure_payment DESC;