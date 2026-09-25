select appointment_id, patient_id, provider_id, appointment_ts,
       initcap(status) status, initcap(appointment_type) appointment_type, ingested_at
from {{ source('raw','appointments') }}
