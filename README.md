# End-to-End Healthcare Data Migration & Analytics — Oracle / SQL Server → Snowflake + dbt

This is a production-style learning project using **synthetic healthcare data only**.
It demonstrates migration, ELT, dimensional modelling, SCD Type 2, incremental processing,
CDC, data quality, security, and BI reporting.

## Business scenario

A healthcare provider operates patient, provider, insurance, appointment, clinical,
claims, billing, and payment systems in Oracle and SQL Server. Leadership wants a
cloud analytics platform in Snowflake to answer:

- How many active patients do we have?
- What are claim volumes and denial rates?
- How much was billed vs paid vs outstanding?
- Which providers and specialties drive activity?
- What is appointment completion / no-show performance?
- How has a patient's insurance or address changed over time?
- What financial and operational trends should managers investigate?

## Architecture

Oracle / SQL Server
        |
        | ADF / Informatica extraction
        v
S3 / Azure Blob / GCS (landing)
        |
        v
Snowflake RAW
        |
        v
dbt STAGING
        |
        v
dbt INTERMEDIATE
        |
        +--> SNAPSHOT (SCD2)
        |
        v
dbt MART
        |
        +--> Power BI / Tableau

## Snowflake layers

- RAW: source-faithful ingestion; no business transformations
- STAGING: standardisation, casting, deduplication, basic quality rules
- INTERMEDIATE: cross-domain joins and reusable business logic
- SNAPSHOT: historical versions of mutable entities
- MART: dimensional model for BI

## Core star schema

Dimensions:
- dim_patient
- dim_provider
- dim_insurance
- dim_date

Facts:
- fct_claim
- fct_billing
- fct_payment
- fct_appointment
- fct_clinical_record

## Security

PHI/PII examples:
- patient name
- date of birth
- address
- postcode
- policy number

The project demonstrates RBAC and column masking. In a real deployment, add
row access policies, network policies, key management, audit monitoring,
retention rules, and organisation-specific compliance controls.

## Important

All data in /data is synthetic and must not be treated as real patient information.
The SQL and dbt configuration are templates that should be reviewed before production use.

## Suggested implementation sequence

1. Load the CSVs into Snowflake RAW.
2. Create external/internal stages as appropriate.
3. Configure dbt-snowflake.
4. Run staging models and tests.
5. Build intermediate models.
6. Add snapshots for patient and insurance history.
7. Build marts.
8. Add incremental claims/billing models.
9. Implement Streams + Tasks for CDC.
10. Apply RBAC and masking.
11. Connect Power BI/Tableau to the mart layer.
12. Validate totals against source systems.

## Hands-on implementation

This repository is intentionally structured for a two-day, hands-on build. Start with:

`docs/hands-on/00_START_HERE.md`

Then follow the numbered phases under `docs/hands-on/` and validate each phase before moving on.

### Primary implementation stack

For the hands-on build, use Azure Data Factory + Azure Blob concepts, Snowflake, dbt-snowflake and Power BI. S3/GCS and Informatica are documented as equivalent architecture patterns rather than separate live implementations.

### GitHub

The repository is designed to be version-controlled with Git and includes a GitHub Actions dbt CI workflow template. Secrets must be supplied through GitHub Secrets and never committed to source control.

## CI/CD

GitHub Actions validates the dbt project on pull requests by running dependency installation, project parsing, and dbt build/tests against the development environment.
