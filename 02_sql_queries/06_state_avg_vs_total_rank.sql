-- ==========================================
-- QUERY: Compare average payment rank and total payment rank by state
-- PURPOSE:
-- Identify whether states with high average payments
-- also have high total estimated outpatient payments.
-- ==========================================

WITH state_summary AS (
  SELECT
    provider_state,
    ROUND(AVG(average_total_payments), 2) AS avg_payment,
    ROUND(SUM(outpatient_services * average_total_payments), 2) AS estimated_total_payments,
    SUM(outpatient_services) AS total_services
  FROM
    `bigquery-public-data.cms_medicare.outpatient_charges_2015`
  GROUP BY
    provider_state
),

ranked_states AS (
  SELECT
    provider_state,
    avg_payment,
    estimated_total_payments,
    total_services,
    RANK() OVER (ORDER BY avg_payment DESC) AS avg_payment_rank,
    RANK() OVER (ORDER BY estimated_total_payments DESC) AS total_payment_rank
  FROM
    state_summary
)

SELECT
  provider_state,
  avg_payment,
  avg_payment_rank,
  estimated_total_payments,
  total_payment_rank,
  total_services
FROM
  ranked_states
ORDER BY
  total_payment_rank;