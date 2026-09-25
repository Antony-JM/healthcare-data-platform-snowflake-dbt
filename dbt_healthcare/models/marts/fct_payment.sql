select payment_id, claim_id, patient_id, payment_date,
       payment_amount, payment_method
from {{ ref('stg_payments') }}
