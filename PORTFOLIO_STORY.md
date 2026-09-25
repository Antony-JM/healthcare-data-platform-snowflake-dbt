# Portfolio Project Story

## Project title
Healthcare Data Migration & Analytics Platform — Oracle / SQL Server to Snowflake using ADF + dbt

## One-line summary
Designed a cloud ELT platform that ingests healthcare operational data into Snowflake, transforms it with dbt, preserves history with SCD Type 2, processes changes incrementally with Streams/Tasks, secures PHI/PII, and serves Power BI-ready dimensional marts.

## Scope
Patients | Providers | Insurance | Appointments | Clinical | Claims | Billing | Payments

## Key engineering patterns
- Batch + incremental ingestion
- Metadata-driven ADF orchestration
- RAW-to-MART layered Snowflake architecture
- dbt staging/intermediate/mart models
- dbt tests and custom SQL tests
- SCD Type 2 snapshots
- Snowflake Streams/Tasks + MERGE
- RBAC + masking
- Audit/control tables
- Source/target reconciliation
- Power BI star-schema reporting
