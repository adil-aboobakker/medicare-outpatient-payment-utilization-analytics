-- ==========================================
-- QUERY: Ranked estimated total payments by state
-- PURPOSE:
-- Identify which states account for the highest
-- estimated Medicare outpatient payments.
-- ==========================================

WITH total_payments AS (
  SELECT
    provider_state,
    ROUND(SUM(outpatient_services * average_total_payments), 2) AS estimated_total_payments
  FROM 
    `bigquery-public-data.cms_medicare.outpatient_charges_2015`
  GROUP BY
    provider_state
)

SELECT
  provider_state,
  estimated_total_payments,
  RANK() OVER (ORDER BY estimated_total_payments DESC) AS payment_rank
FROM
  total_payments
ORDER BY
  payment_rank;