-- ==========================================
-- DATA VALIDATION
-- PURPOSE:
-- Validate structure, completeness, and basic
-- quality of the Medicare outpatient dataset.
-- ==========================================

-- 1. Row count
SELECT
  COUNT(*) AS total_rows
FROM
  `bigquery-public-data.cms_medicare.outpatient_charges_2015`;

  -- 2. Distinct counts for key dimensions
SELECT
  COUNT(DISTINCT provider_id) AS distinct_providers,
  COUNT(DISTINCT provider_state) AS distinct_states,
  COUNT(DISTINCT apc) AS distinct_apcs,
  COUNT(DISTINCT hospital_referral_region) AS distinct_hrrs
FROM
  `bigquery-public-data.cms_medicare.outpatient_charges_2015`;

  -- 3. Null checks
SELECT
  COUNTIF(provider_id IS NULL) AS null_provider_id,
  COUNTIF(provider_name IS NULL) AS null_provider_name,
  COUNTIF(provider_state IS NULL) AS null_provider_state,
  COUNTIF(apc IS NULL) AS null_apc,
  COUNTIF(outpatient_services IS NULL) AS null_outpatient_services,
  COUNTIF(average_total_payments IS NULL) AS null_average_total_payments
FROM
  `bigquery-public-data.cms_medicare.outpatient_charges_2015`;

  -- 4. Check for zero or negative values
SELECT
  COUNTIF(outpatient_services <= 0) AS zero_or_negative_services,
  COUNTIF(average_total_payments <= 0) AS zero_or_negative_avg_payments
FROM
  `bigquery-public-data.cms_medicare.outpatient_charges_2015`;

  -- 5. Check duplicate provider/APC combinations
SELECT
  provider_id,
  apc,
  COUNT(*) AS record_count
FROM
  `bigquery-public-data.cms_medicare.outpatient_charges_2015`
GROUP BY
  provider_id,
  apc
HAVING
  COUNT(*) > 1
ORDER BY
  record_count DESC;

  -- 6. List states included in the dataset
SELECT
  provider_state,
  COUNT(*) AS row_count
FROM
  `bigquery-public-data.cms_medicare.outpatient_charges_2015`
GROUP BY
  provider_state
ORDER BY
  provider_state;