# Healthcare Data Platform — Operations Runbook

## 1. Purpose

This runbook provides operational procedures for monitoring, troubleshooting, and validating the healthcare data platform across DEV, QA, and PROD environments.

## 2. Environment Flow

DEV → QA → PROD

Changes should be validated in DEV before promotion to QA and PROD.

## 3. dbt Test Failure

Run:

```bash
cd dbt_healthcare
dbt test --target dev

If a test fails:
1. Identify the failing model or source.
2. Review the failing test definition.
3. Query the affected data.
4. Determine whether the issue is a source-data problem or transformation problem.
5. Correct the underlying issue.
6. Re-run the affected test.
7. Run the full dbt test suite before promotion.
4. Source Freshness Warning
Run:
cd dbt_healthcare
dbt source freshness --target dev

Current thresholds:
- Less than 24 hours — Pass
- 24–48 hours — Warning
- More than 48 hours — Error
For a stale source:
1. Identify the affected RAW table.
2. Check the latest INGESTED_AT.
3. Verify whether the upstream ingestion process completed.
4. Check the Snowflake landing/stage process.
5. Validate RAW row counts.
6. Re-run source freshness.
7. Re-run downstream dbt models if required.
5. Financial Reconciliation Failure
Claims financial reconciliation follows:
Billed Amount - Paid Amount - Balance Amount = 0
If reconciliation fails:
1. Identify affected claims.
2. Compare claim amounts with payment transactions.
3. Check for missing or duplicate payments.
4. Validate the billing and payment source data.
5. Correct the source or transformation issue.
6. Re-run the reconciliation test.
6. CDC Failure
CDC processing uses Snowflake Streams and Tasks.
If CDC processing fails:
1. Check whether the stream contains unprocessed records.
2. Check task status.
3. Review the MERGE logic.
4. Validate the target CDC table.
5. Re-run processing if required.
6. Confirm that the target reflects the latest source state.
7. QA Deployment Validation
After deployment to QA:
cd dbt_healthcare
dbt build --target qa

Validate:
- Model build success
- dbt tests
- Row counts
- Referential integrity
- Financial reconciliation
- Incremental models
- CDC models
8. PROD Deployment Validation
After deployment to PROD:
cd dbt_healthcare
dbt test --target prod

Validate:
- Required snapshots exist
- MART models are available
- Data-quality tests pass
- Security objects remain accessible
- Expected environment/database is being used
9. GitHub Actions CI
Pull requests trigger the dbt CI workflow.
The CI workflow performs:
1. Repository checkout
2. Python setup
3. dbt installation
4. Snowflake authentication
5. dbt package installation
6. dbt parse
7. dbt build
A pull request should not be merged until CI completes successfully.
10. Incident Documentation
For production incidents record:
- Date/time
- Environment
- Affected source/model
- Failure message
- Root cause
- Resolution
- Validation performed
- Follow-up action


