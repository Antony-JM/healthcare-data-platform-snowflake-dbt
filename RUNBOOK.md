# Production-style runbook

## Daily
- Check ADF extraction status.
- Check Snowflake load history.
- Check dbt run/test status.
- Review rejected records.
- Reconcile row counts and financial totals.

## Failure handling
If extraction fails: do not advance the watermark.
If RAW load fails: quarantine the batch.
If dbt tests fail: block downstream BI refresh.
If a mart fails: preserve the previous successful mart and investigate the failed batch.

## DEV / QA / PROD
Use separate databases:
DEV_HEALTH_DB
QA_HEALTH_DB
PROD_HEALTH_DB

Promote code through Git pull request → CI tests → QA validation → production deployment.
Credentials must be stored in a secret manager, never in Git.
