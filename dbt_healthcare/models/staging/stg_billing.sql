select billing_id, claim_id, patient_id, billing_date,
       billed_amount, initcap(billing_status) billing_status, ingested_at
from {{ source('raw','billing') }}
