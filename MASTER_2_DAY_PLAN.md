# Master 2-Day Implementation Plan

## Day 1 — Foundation to Mart

### 09:00–10:00 | Business & source understanding
- Healthcare domains: Patients, Providers, Insurance, Appointments, Clinical, Claims, Billing, Payments
- Define source-of-truth, grain, PK/FK relationships, business rules
- Review source-to-target mapping

### 10:00–12:00 | Snowflake foundation
- DEV/QA/PROD databases
- RAW/STAGING/INTERMEDIATE/SNAPSHOT/MART/SECURITY schemas
- Warehouse, stages, file formats, raw tables
- COPY INTO load pattern

### 13:00–15:30 | dbt
- Sources
- Staging models
- Intermediate models
- Dimensions/facts
- dbt tests
- Documentation and lineage

### 15:30–17:00 | SCD Type 2
- Patient address history
- Insurance history
- Provider/doctor assignment history
- Snapshot validation

### 17:00–18:00 | Reconciliation
- Source vs RAW
- RAW vs STAGING
- STAGING vs MART
- Financial totals

## Day 2 — Production features

### 09:00–11:00 | Incremental + CDC
- New patients
- Updated claims
- Corrected billing
- Streams
- Tasks
- MERGE
- Watermarks

### 11:00–12:00 | Security
- RBAC
- PHI/PII inventory
- Column masking
- Least privilege

### 13:00–14:30 | ADF orchestration
- Full load
- Incremental load
- Parameterisation
- Audit/control tables
- Retry and failure paths

### 14:30–16:00 | Power BI
- Star schema connection
- Measures
- KPI pages
- RLS/secure access pattern

### 16:00–17:00 | Monitoring + QA
- Pipeline logging
- dbt test failures
- SLA checks
- Data freshness

### 17:00–18:00 | Interview story
- Architecture walkthrough
- Why each technology
- Failure scenarios
- Trade-offs
- Resume/project explanation
