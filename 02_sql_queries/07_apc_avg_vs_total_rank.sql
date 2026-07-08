-- ==========================================
-- QUERY: Compare average payment rank and total payment rank by APC
-- PURPOSE:
-- Identify whether outpatient service categories with
-- high average payments also drive the highest total
-- estimated payments.
-- ==========================================

WITH apc_summary AS (
  SELECT
    apc,
    ROUND(AVG(average_total_payments), 2) AS avg_payment,
    ROUND(SUM(outpatient_services * average_total_payments), 2) AS estimated_total_payments,
    SUM(outpatient_services) AS total_services
  FROM
    `bigquery-public-data.cms_medicare.outpatient_charges_2015`
  GROUP BY
    apc
),

ranked_apcs AS (
  SELECT
    apc,
    avg_payment,
    estimated_total_payments,
    total_services,
    RANK() OVER (ORDER BY avg_payment DESC) AS avg_payment_rank,
    RANK() OVER (ORDER BY estimated_total_payments DESC) AS total_payment_rank,
    RANK() OVER (ORDER BY total_services DESC) AS volume_rank
  FROM
    apc_summary
)

SELECT
  apc,
  avg_payment,
  avg_payment_rank,
  estimated_total_payments,
  total_payment_rank,
  total_services,
  volume_rank
FROM
  ranked_apcs
ORDER BY
  total_payment_rank;