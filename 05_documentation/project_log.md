# Day 1

## Dataset Selection

Selected:
bigquery-public-data.cms_medicare.outpatient_charges_2015

Reason:
Real Medicare outpatient healthcare payment data suitable for healthcare quality and utilization analytics.

## Data Validation Results

Dataset:
bigquery-public-data.cms_medicare.outpatient_charges_2015

Validation checks performed:
- Total row count
- Distinct provider count
- Distinct state count
- Distinct APC count
- Distinct hospital referral region count
- Null checks for key analytical fields

Results:
- Total rows: 32,532
- Distinct providers: 3,021
- Distinct states: 50
- Distinct APC categories: 28
- Distinct hospital referral regions: 304
- Null values in key fields: None found

Interpretation:
The dataset is structured and complete enough for analysis. Key analytical fields such as provider, state, APC, service volume, and average payment did not contain null values. The dataset appears suitable for state-level, APC-level, provider-level, and regional outpatient payment analysis.

## Initial Schema Review

Fields identified:

- provider_id
- provider_name
- provider_state
- apc
- hospital_referral_region
- outpatient_services
- average_total_payments

# Initial Findings
## State-Level Payment Analysis
Objective:
Identify states with the highest average Medicare outpatient payments.
Results:
States analyzed: 50
Highest average payment state: Massachusetts
Average payment: approximately $477.50
Observation:
Significant variation exists across states. Further investigation is required to determine whether differences are driven by procedure mix, provider characteristics, or regional healthcare cost patterns.

# Procedure Cost Analysis
Objective:
Identify outpatient procedure categories with the highest average Medicare payments.
Results:
Highest-cost APC: Level 4 Endoscopy Upper Airway
Average payment: approximately $1,920
Top five APC categories all exceeded $1,000 average payment.
Significant payment drop-off observed after the fifth-ranked APC category.
Observation:
A small number of procedure categories account for substantially higher average Medicare payments. These procedures may warrant additional investigation for resource utilization and cost management.

## Estimated Total Payments Analysis

Objective:
Identify which outpatient service categories have the greatest overall financial impact by combining service volume and average payment.

Method:
Created a derived metric:

estimated_total_payments = average_total_payments × outpatient_services

Results:

* Hospital clinic visits had the highest estimated total payments.
* This APC was also the highest-volume outpatient service category.
* The highest average payment APC was not the highest total payment APC.

Key Insight:
High average payment does not necessarily mean highest overall financial impact. In this dataset, total estimated payments were driven more by service volume than by per-service payment amount.

Analytical Importance:
This finding shows the difference between cost intensity and system-wide financial impact. Healthcare organizations should evaluate both average payment and utilization volume when identifying major cost drivers.

## State-Level Total Payment Analysis

Objective:
Compare state-level Medicare outpatient financial impact using estimated total payments.

Method:
Created a state-level summary using a CTE and ranked states by estimated total payments.

Results:

* California ranked first in estimated total outpatient payments.
* California estimated total payments: approximately $397 million.
* Massachusetts ranked sixth by estimated total payments, despite having the highest average payment.

Key Insight:
Average payment and total financial impact tell different stories. Massachusetts had the highest average outpatient payment, but California had the greatest overall estimated payments due to higher service volume.

SQL Skills Practiced:

* Common Table Expression (CTE)
* Derived metric calculation
* GROUP BY aggregation
* RANK() window function
* State-level benchmarking

## State Average Payment vs Total Payment Ranking

Objective:
Compare state rankings by average outpatient payment and estimated total outpatient payments.

Method:
Used CTEs to summarize state-level average payments, total services, and estimated total payments. Applied RANK() window functions to compare states across average payment rank and total payment rank.

Results:

* California ranked #1 by estimated total payments.
* Massachusetts ranked #1 by average payment.
* Massachusetts ranked #6 by estimated total payments.
* New York ranked #2 by estimated total payments despite ranking #14 by average payment.

Key Insight:
Average payment and total payment rankings tell different stories. States with high service volume can have greater total financial impact even when their average payment is not the highest.

Analytical Importance:
This reinforces the need to evaluate both per-service payment intensity and total utilization when analyzing healthcare spending patterns.

## APC Average Payment vs Total Payment Ranking

Objective:
Compare outpatient procedure categories by average payment, total service volume, and estimated total payments.

Method:
Used CTEs to summarize APC-level metrics and applied RANK() window functions to compare:

* average payment rank
* estimated total payment rank
* service volume rank

Results:

* Hospital clinic visits ranked #1 by estimated total payments.
* Hospital clinic visits also ranked #1 by service volume.
* Level 4 Endoscopy Upper Airway ranked #1 by average payment.
* The highest average payment APC was not the highest total payment APC.

Key Insight:
APCs with the highest per-service payments are not necessarily the largest drivers of overall Medicare outpatient payments. Hospital clinic visits had the greatest total payment impact because of very high service volume.

Analytical Importance:
This reinforces the importance of analyzing both payment intensity and utilization volume when evaluating healthcare spending patterns.

## Provider-Level Payment Ranking

Objective:
Identify providers with the highest estimated Medicare outpatient payment impact.

Method:
Grouped outpatient records by provider and calculated:

* estimated total payments
* total services
* average payment
* provider payment rank

Results:

* Cleveland Clinic in Cleveland, Ohio ranked #1 by estimated total outpatient payments.
* Cleveland Clinic also had the highest total service volume among providers.
* Its top ranking was driven primarily by utilization volume rather than the highest average payment.

Key Insight:
At the provider level, high total payment impact was again driven by service volume. This supports the broader project finding that utilization volume is a major driver of total Medicare outpatient payments.
