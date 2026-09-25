select payment_id, claim_id, patient_id, payment_date,
       payment_amount, initcap(payment_method) payment_method, ingested_at
from {{ source('raw','payments') }}
