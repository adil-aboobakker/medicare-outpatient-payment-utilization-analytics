SELECT
  provider_state,
  AVG(average_total_payments) AS avg_state_payment
FROM `bigquery-public-data.cms_medicare.outpatient_charges_2015`
GROUP BY provider_state
ORDER BY avg_state_payment DESC;