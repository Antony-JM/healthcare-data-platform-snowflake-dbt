# ADF / Informatica pipeline design

## Pipeline 1 — Full migration
1. Lookup source control table.
2. Copy Oracle / SQL Server table to cloud landing.
3. Preserve source filename, extraction timestamp, source system and batch_id.
4. Load Snowflake RAW using COPY INTO or Snowpipe.
5. Run dbt staging → intermediate → snapshots → marts.
6. Run dbt tests.
7. Write audit results.

## Pipeline 2 — Incremental / CDC
1. Read source watermark (SCN, modified_timestamp, Change Tracking/CDC).
2. Extract only changed records.
3. Land files in date-partitioned folder.
4. Load RAW.
5. Update Snowflake Stream.
6. Run Task / dbt job.
7. MERGE into target.
8. Update watermark only after successful completion.

## Landing convention

s3://healthcare-landing/<source>/<entity>/extract_date=YYYY-MM-DD/batch_id=<id>/

Equivalent Azure Blob / GCS structures can be used.

## Audit columns

batch_id
source_system
source_table
file_name
extract_started_at
extract_completed_at
row_count
checksum
load_status
error_message

## Reconciliation

For each batch compare:
- source row count vs raw row count
- source financial totals vs raw totals
- raw vs mart row counts
- rejected/null/duplicate counts
- claim billed and paid totals
