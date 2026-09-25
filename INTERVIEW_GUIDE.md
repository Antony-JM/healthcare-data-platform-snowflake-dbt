# How to explain this project in an interview

"I worked on a healthcare cloud data platform migrating operational data from Oracle and
SQL Server into Snowflake. ADF handled extraction and landing into cloud object storage.
The RAW layer preserved source data, while dbt implemented the ELT transformation layers.
We created staging models for standardisation and deduplication, intermediate models for
cross-domain business logic, snapshots for SCD Type 2 history, and dimensional marts for
Power BI/Tableau.

For changing claims and billing records, we used incremental dbt models with MERGE semantics.
For near-real-time change processing, Snowflake Streams captured changes and Tasks triggered
downstream processing. We implemented dbt tests for uniqueness, not-null, referential
integrity and business rules. RBAC and masking policies protected PHI/PII.

The final mart contained patient, provider, insurance and date dimensions plus claim,
billing, payment, appointment and clinical facts."

## Questions to prepare
1. Why ELT instead of ETL for Snowflake?
2. Why keep a RAW layer if dbt can transform data?
3. Snapshot vs incremental model?
4. SCD Type 1 vs Type 2?
5. Stream vs Task?
6. Snowpipe vs COPY INTO?
7. How do you handle late-arriving claims?
8. How do you reconcile source and target?
9. How do you prevent duplicate loads?
10. How would you secure PHI in Power BI?
11. What happens when a dbt test fails?
12. How would you promote DEV → QA → PROD?
