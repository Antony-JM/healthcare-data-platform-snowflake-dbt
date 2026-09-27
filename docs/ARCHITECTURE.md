# Healthcare Data Platform — Architecture

## 1. Overview

This project demonstrates an end-to-end healthcare data platform for integrating operational healthcare data into Snowflake and transforming it into analytics-ready datasets using dbt.

The platform covers:

- Patient data
- Provider data
- Insurance
- Appointments
- Clinical records
- Claims
- Billing
- Payments
- Doctor assignments

The implementation uses synthetic healthcare data and does not contain real patient information.

---

## 2. High-Level Architecture

```text
┌──────────────────────────────┐
│        Source Systems        │
│                              │
│  Oracle / SQL Server         │
│  Healthcare Applications     │
└──────────────┬───────────────┘
               │
               │ Extraction
               ▼
┌──────────────────────────────┐
│      Ingestion Layer         │
│                              │
│ Azure Data Factory           │
│ Informatica                  │
└──────────────┬───────────────┘
               │
               │ Files / Data
               ▼
┌──────────────────────────────┐
│       Landing Zone            │
│                              │
│ Azure Blob / AWS S3 / GCS    │
└──────────────┬───────────────┘
               │
               │ Load
               ▼
┌──────────────────────────────┐
│          Snowflake           │
│                              │
│ RAW                          │
│ STAGING                      │
│ INTERMEDIATE                 │
│ SNAPSHOT                     │
│ MART                         │
│ SECURITY                     │
│ AUDIT                        │
└──────────────┬───────────────┘
               │
               │ Analytics
               ▼
┌──────────────────────────────┐
│       BI / Analytics         │
│                              │
│ Power BI / Tableau           │
└──────────────────────────────┘

3. Snowflake Data Layers
RAW
The RAW layer contains source-ingested healthcare data with minimal transformation.
Source domains include:
- Patients
- Providers
- Insurance
- Appointments
- Clinical records
- Claims
- Billing
- Payments
- Doctor assignments
RAW also supports ingestion metadata such as INGESTED_AT.
STAGING
The dbt STAGING layer standardizes source data.
Typical transformations include:
- Deduplication
- Data type normalization
- String cleanup
- Status normalization
- Source-level relationship validation
INTERMEDIATE
The INTERMEDIATE layer combines and aggregates staging models into business-ready intermediate datasets.
Examples include:
- Patient activity
- Claim financials
- Payment aggregation
SNAPSHOT
The SNAPSHOT layer tracks historical changes using dbt snapshots / SCD Type 2 patterns.
Examples:
- Patient address changes
- Insurance changes
- Doctor assignment changes
MART
The MART layer provides analytics-ready fact and dimension models.
Dimensions include:
- Patient
- Provider
- Insurance
- Date
Facts include:
- Claims
- Billing
- Payments
- Appointments
- Clinical records
The MART layer also contains healthcare KPI reporting models.
SECURITY
The SECURITY layer contains security-oriented objects such as secure views used for PHI/PII masking.
AUDIT
The AUDIT layer contains operational audit and reconciliation information, including batch-level ingestion tracking.
4. Data Transformation Architecture
The transformation flow is:
RAW
 ↓
dbt STAGING
 ↓
dbt INTERMEDIATE
 ↓
dbt SNAPSHOT
 ↓
dbt MART

dbt manages transformation dependencies using model references.
This provides:
- Dependency management
- Reproducible transformations
- Automated testing
- Environment-specific deployment
- Version-controlled SQL
5. Incremental Processing
Large transactional datasets are processed incrementally where appropriate.
Incremental models are used for datasets such as:
- Claims
- Billing
- CDC-derived claim data
The incremental strategy avoids rebuilding the entire target dataset for every run.
The project uses dbt incremental models with merge-based processing.
6. CDC Architecture
Change Data Capture is implemented using Snowflake Streams and Tasks.
RAW CLAIMS
     │
     ▼
Snowflake Stream
     │
     ▼
Snowflake Task
     │
     ▼
MERGE
     │
     ▼
FCT_CLAIM_CDC

The stream captures changes to the source table.
The task processes the changes and merges them into the CDC target.
7. SCD Type 2
Historical changes are tracked using dbt snapshots.
Example:
Patient P00001

Version 1
Address = Old Address
Valid From = T1
Valid To   = T2
Current    = No

Version 2
Address = New Address
Valid From = T2
Valid To   = NULL
Current    = Yes

This allows historical analysis without overwriting previous values.
8. Data Quality
The project uses dbt tests for:
- Uniqueness
- Not-null validation
- Referential integrity
- Financial reconciliation
- KPI validation
- Snapshot integrity
The DEV environment currently contains 90 dbt tests.
Source freshness monitoring is also configured using INGESTED_AT.
Current thresholds:
- Less than 24 hours — Pass
- 24–48 hours — Warning
- More than 48 hours — Error
9. Security Architecture
Snowflake RBAC is used to separate responsibilities.
Project roles include:
- HEALTHCARE_ADMIN
- HEALTHCARE_ANALYST
- HEALTHCARE_SUPPORT
The project uses a secure-view approach for masking sensitive patient address information.
This implementation uses secure views because the Snowflake account used for the hands-on project does not provide the Enterprise-level dynamic masking capability.
Sensitive values are exposed according to the user's Snowflake role.
10. Environment Architecture
The platform uses separate Snowflake databases:
DEV_HEALTH_DB
QA_HEALTH_DB
PROD_HEALTH_DB

The same dbt project is promoted across environments using different dbt targets.
             ┌───────────────┐
             │     dbt       │
             └───────┬───────┘
                     │
          ┌──────────┼──────────┐
          ▼          ▼          ▼
        DEV         QA         PROD
        DB           DB          DB

Environment-specific database references are resolved through the dbt target configuration.
11. CI/CD
GitHub Actions validates dbt changes through pull requests.
The CI workflow performs:
Checkout
   ↓
Python Setup
   ↓
Install dbt
   ↓
Snowflake Authentication
   ↓
dbt deps
   ↓
dbt parse
   ↓
dbt build

Snowflake credentials are stored using GitHub repository secrets and are not committed to source control.
12. Data Quality & Observability
The platform provides multiple layers of operational validation:
Source Freshness
      ↓
dbt Data Quality Tests
      ↓
Financial Reconciliation
      ↓
CDC Validation
      ↓
Environment Validation

Operational procedures are documented in:
docs/OPERATIONS_RUNBOOK.md
13. BI / Analytics Layer
The MART layer is designed to support BI tools.
The project documents Power BI as the target enterprise BI architecture and uses Tableau Public for hands-on visualization where required by the local development environment.
Example analytics areas include:
- Patient activity
- Claims performance
- Billing
- Payments
- Appointment activity
- Clinical activity
- Healthcare KPIs
14. Hands-On vs Production Architecture
The project distinguishes between the technologies demonstrated directly and the production architecture they represent.
Hands-On Implementation
The local project directly demonstrates:
- Synthetic CSV source data
- Snowflake internal staging
- Snowflake RAW tables
- dbt transformations
- dbt snapshots
- Snowflake Streams and Tasks
- Snowflake RBAC
- Secure views
- GitHub Actions CI
Production Pattern
A production implementation could use:
- Oracle / SQL Server source systems
- Azure Data Factory or Informatica
- Azure Blob Storage / AWS S3 / GCP GCS
- Snowflake cloud data warehouse
- dbt Cloud or enterprise dbt execution
- Enterprise Snowflake security features
- Power BI enterprise deployment
The architecture intentionally documents both so that the portfolio project demonstrates practical implementation while also showing how the same patterns scale to an enterprise environment.
