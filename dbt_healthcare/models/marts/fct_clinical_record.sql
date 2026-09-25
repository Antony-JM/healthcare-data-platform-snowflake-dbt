select clinical_id, patient_id, provider_id, record_date,
       diagnosis, clinical_status
from {{ ref('stg_clinical_records') }}
