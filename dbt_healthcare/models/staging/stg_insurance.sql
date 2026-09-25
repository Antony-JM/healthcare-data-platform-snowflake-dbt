with ranked as (
  select *, row_number() over (
    partition by insurance_id order by ingested_at desc
  ) rn
  from {{ source('raw','insurance') }}
)
select insurance_id, patient_id, trim(payer_name) payer_name,
       trim(policy_number) policy_number, effective_date, expiry_date,
       initcap(status) status, ingested_at
from ranked where rn = 1
