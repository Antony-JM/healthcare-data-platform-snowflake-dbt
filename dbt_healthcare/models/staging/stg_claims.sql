with ranked as (
  select *, row_number() over (
    partition by claim_id order by ingested_at desc
  ) rn
  from {{ source('raw','claims') }}
)
select claim_id, patient_id, provider_id, service_date,
       initcap(claim_status) claim_status,
       billed_amount, paid_amount, balance_amount, ingested_at
from ranked where rn = 1
