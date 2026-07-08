-- ==========================================
-- QUERY: KPI Summary
-- PURPOSE:
-- Create summary metrics for dashboard KPI cards.
-- ==========================================

SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT provider_id) AS distinct_providers,
  COUNT(DISTINCT provider_state) AS distinct_states,
  COUNT(DISTINCT apc) AS distinct_apcs,
  ROUND(AVG(average_total_payments), 2) AS overall_avg_payment,
  ROUND(SUM(outpatient_services), 0) AS total_outpatient_services,
  ROUND(SUM(outpatient_services * average_total_payments), 2) AS estimated_total_payments
FROM
  `bigquery-public-data.cms_medicare.outpatient_charges_2015`;