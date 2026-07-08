SELECT
  apc,
  SUM(outpatient_services) as total_outpatient_visits
FROM
  `bigquery-public-data.cms_medicare.outpatient_charges_2015` 
GROUP BY
  apc
ORDER BY
  SUM(outpatient_services) DESC;