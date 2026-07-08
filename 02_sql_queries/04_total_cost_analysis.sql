-- ==========================================
-- QUERY: Total estimated payment by APC
-- PURPOSE:
-- Identify outpatient procedure categories
-- with the highest total financial impact
-- based on payment multiplied by service volume.
-- ==========================================

SELECT  
  apc,
  ROUND(SUM(average_total_payments * outpatient_services), 2) AS estimated_total_payments
FROM 
  `bigquery-public-data.cms_medicare.outpatient_charges_2015`
GROUP BY 
  apc
ORDER BY 
  estimated_total_payments DESC;