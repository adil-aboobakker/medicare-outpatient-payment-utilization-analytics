-- ==========================================
-- QUERY: Ranked estimated total payments by provider
-- PURPOSE:
-- Identify providers with the highest estimated
-- Medicare outpatient payment impact.
-- ==========================================

WITH provider_summary AS (
  SELECT
    provider_id,
    provider_name,
    provider_city,
    provider_state,
    ROUND(SUM(outpatient_services * average_total_payments), 2) AS estimated_total_payments,
    SUM(outpatient_services) AS total_services,
    ROUND(AVG(average_total_payments), 2) AS avg_payment
  FROM
    `bigquery-public-data.cms_medicare.outpatient_charges_2015`
  GROUP BY
    provider_id,
    provider_name,
    provider_city,
    provider_state
),

ranked_providers AS (
  SELECT
    provider_id,
    provider_name,
    provider_city,
    provider_state,
    estimated_total_payments,
    total_services,
    avg_payment,
    RANK() OVER (ORDER BY estimated_total_payments DESC) AS provider_payment_rank
  FROM
    provider_summary
)

SELECT
  provider_payment_rank,
  provider_id,
  provider_name,
  provider_city,
  provider_state,
  estimated_total_payments,
  total_services,
  avg_payment
FROM
  ranked_providers
ORDER BY
  provider_payment_rank
LIMIT 20;