select appointment_id, patient_id, provider_id, appointment_ts,
       status, appointment_type
from {{ ref('stg_appointments') }}
