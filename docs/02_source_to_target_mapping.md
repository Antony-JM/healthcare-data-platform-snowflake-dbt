# Source-to-Target Mapping

| Source | RAW | STAGING | MART | Grain |
|---|---|---|---|---|
| Oracle.PATIENT | RAW.PATIENTS | STG_PATIENTS | DIM_PATIENT | 1 row per patient/version |
| Oracle.PROVIDER | RAW.PROVIDERS | STG_PROVIDERS | DIM_PROVIDER | 1 row per provider |
| SQLServer.INSURANCE | RAW.INSURANCE | STG_INSURANCE | DIM_INSURANCE | 1 row per insurance record |
| SQLServer.APPOINTMENT | RAW.APPOINTMENTS | STG_APPOINTMENTS | FCT_APPOINTMENT | 1 row per appointment |
| Oracle.CLAIM | RAW.CLAIMS | STG_CLAIMS | FCT_CLAIM | 1 row per claim |
| SQLServer.BILLING | RAW.BILLING | STG_BILLING | FCT_BILLING | 1 row per billing transaction |
| SQLServer.PAYMENT | RAW.PAYMENTS | STG_PAYMENTS | FCT_PAYMENT | 1 row per payment |
| Oracle.CLINICAL_RECORD | RAW.CLINICAL_RECORDS | STG_CLINICAL_RECORDS | FCT_CLINICAL_RECORD | 1 row per clinical event |
| SQLServer.DOCTOR_ASSIGNMENT | RAW.DOCTOR_ASSIGNMENTS | STG_DOCTOR_ASSIGNMENTS | SNAPSHOT_DOCTOR_ASSIGNMENT | 1 row per assignment/version |

## Standard audit columns
- batch_id
- source_system
- source_table
- source_extract_ts
- ingested_at
- record_hash (recommended for CDC/change detection)
