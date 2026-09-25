# Business Requirements

## Objective
Create a cloud healthcare analytics platform that consolidates operational healthcare data from Oracle and SQL Server into Snowflake for trusted reporting and historical analysis.

## Business questions
1. How many active patients are being served?
2. What is appointment completion and no-show performance?
3. What are billed, paid, denied and outstanding claim amounts?
4. Which providers/specialties drive activity and financial volume?
5. How long do claims remain outstanding?
6. How have patient addresses changed over time?
7. How has insurance coverage changed over time?
8. Which doctor was assigned to a patient at a given point in time?

## Functional requirements
- Full migration of reference and historical data.
- Incremental ingestion using watermark/CDC.
- Historical change tracking using SCD Type 2.
- Reusable dbt transformations.
- Automated data quality tests.
- Secure PHI/PII access.
- BI-ready star schema.

## Non-functional requirements
- Idempotent loads.
- Traceable batch IDs.
- Source-to-target reconciliation.
- DEV/QA/PROD isolation.
- Retryable orchestration.
- No credentials in source control.
- Auditability of data loads and transformations.
