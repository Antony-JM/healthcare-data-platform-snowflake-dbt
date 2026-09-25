# QA Test Matrix

| Test | Expected result |
|---|---|
| Patient PK uniqueness | 0 duplicates |
| Claim PK uniqueness | 0 duplicates |
| Claim -> Patient FK | 0 orphan claims |
| Claim -> Provider FK | 0 orphan providers |
| Billed = Paid + Balance | Within tolerance |
| RAW row count vs source | Exact for full load |
| Incremental watermark | Only new/changed rows |
| Snapshot history | Previous versions preserved |
| Masking | Non-privileged roles see masked PII |
| DEV/QA/PROD isolation | No accidental cross-env writes |
| BI totals | Match MART totals |
