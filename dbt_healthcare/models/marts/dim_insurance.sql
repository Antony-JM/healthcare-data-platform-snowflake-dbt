select insurance_id, patient_id, payer_name, policy_number,
       effective_date, expiry_date, status
from {{ ref('stg_insurance') }}
