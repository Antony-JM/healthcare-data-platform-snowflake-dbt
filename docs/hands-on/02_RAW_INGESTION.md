# Hands-on 02 — Local landing -> Snowflake RAW

## Objective

Build the first working pipeline using synthetic healthcare data:

`data/*.csv -> landing/full_load/YYYY-MM-DD/ -> Snowflake internal stage -> RAW`

Production equivalent:

`Oracle / SQL Server -> ADF -> Azure Blob/S3/GCS -> Snowflake RAW`

## 1. Prepare the local landing zone

From the repository root:

```bash
mkdir -p landing/full_load/2026-09-26
cp data/*.csv landing/full_load/2026-09-26/
ls -lh landing/full_load/2026-09-26/
```

## 2. Validate source data before loading

Run:

```bash
python3 scripts/validate_source_data.py
```

The clean baseline should pass. We will introduce intentional bad data later to demonstrate QA controls.

## 3. Create RAW tables

Open `snowflake/02_raw_tables.sql` in VS Code and execute it in Snowsight.

Then:

```sql
SHOW TABLES IN SCHEMA DEV_HEALTH_DB.RAW;
```

Expected tables:

- PATIENTS
- PROVIDERS
- INSURANCE
- APPOINTMENTS
- CLINICAL_RECORDS
- CLAIMS
- BILLING
- PAYMENTS
- DOCTOR_ASSIGNMENTS

## 4. Create the landing stage

Execute `snowflake/05_stages_and_copy.sql`.

## 5. Upload files without installing another cloud service

In Snowsight:

`Ingestion -> Add Data -> Load files into a Stage`

Select the nine CSVs under:

`landing/full_load/2026-09-26/`

Choose:

`DEV_HEALTH_DB -> RAW -> HEALTH_LANDING_STAGE`

Create/use the path:

`full_load/2026-09-26/`

Snowflake supports uploading multiple local files to a named internal stage from Snowsight. The current documented maximum is 250 MB per file.

## 6. Verify staged files

Run:

```sql
LIST @DEV_HEALTH_DB.RAW.HEALTH_LANDING_STAGE/full_load/2026-09-26/;
```

## 7. Load PATIENTS first

Use this as the pattern:

```sql
COPY INTO DEV_HEALTH_DB.RAW.PATIENTS
FROM (
  SELECT
    $1,$2,$3,TO_DATE($4),$5,$6,$7,$8,$9,$10,TO_DATE($11),
    'ORACLE',
    'PATIENT',
    'FULL_20260926_001',
    METADATA$FILENAME,
    CURRENT_TIMESTAMP()
  FROM @DEV_HEALTH_DB.RAW.HEALTH_LANDING_STAGE/full_load/2026-09-26/patients.csv
)
FILE_FORMAT = (FORMAT_NAME = 'DEV_HEALTH_DB.RAW.FF_CSV')
ON_ERROR = 'ABORT_STATEMENT';
```

After loading:

```sql
SELECT COUNT(*) FROM DEV_HEALTH_DB.RAW.PATIENTS;
SELECT * FROM DEV_HEALTH_DB.RAW.PATIENTS LIMIT 5;
```

## 8. Repeat for the other entities

Use the column mappings documented in `docs/02_source_to_target_mapping.md`.

Source-system assignment for this demo:

- Oracle: PATIENTS, PROVIDERS, CLAIMS, CLINICAL_RECORDS
- SQL_SERVER: INSURANCE, APPOINTMENTS, BILLING, PAYMENTS, DOCTOR_ASSIGNMENTS

## 9. Reconcile row counts

Run:

```sql
SELECT 'PATIENTS' ENTITY, COUNT(*) ROW_COUNT FROM DEV_HEALTH_DB.RAW.PATIENTS
UNION ALL SELECT 'PROVIDERS', COUNT(*) FROM DEV_HEALTH_DB.RAW.PROVIDERS
UNION ALL SELECT 'INSURANCE', COUNT(*) FROM DEV_HEALTH_DB.RAW.INSURANCE
UNION ALL SELECT 'APPOINTMENTS', COUNT(*) FROM DEV_HEALTH_DB.RAW.APPOINTMENTS
UNION ALL SELECT 'CLINICAL_RECORDS', COUNT(*) FROM DEV_HEALTH_DB.RAW.CLINICAL_RECORDS
UNION ALL SELECT 'CLAIMS', COUNT(*) FROM DEV_HEALTH_DB.RAW.CLAIMS
UNION ALL SELECT 'BILLING', COUNT(*) FROM DEV_HEALTH_DB.RAW.BILLING
UNION ALL SELECT 'PAYMENTS', COUNT(*) FROM DEV_HEALTH_DB.RAW.PAYMENTS
UNION ALL SELECT 'DOCTOR_ASSIGNMENTS', COUNT(*) FROM DEV_HEALTH_DB.RAW.DOCTOR_ASSIGNMENTS;
```

Expected baseline counts are documented by the source CSVs; we will capture them in `BATCH_AUDIT` after the loads are confirmed.

## 10. Git checkpoint

After the first successful RAW load, commit:

```bash
git add snowflake/ docs/hands-on/ data/doctor_assignments.csv scripts/validate_source_data.py

git commit -m "feat: build healthcare raw ingestion layer"
git push
```
