select clinical_id, patient_id, provider_id, record_date,
       initcap(diagnosis) diagnosis, initcap(clinical_status) clinical_status, ingested_at
from {{ source('raw','clinical_records') }}
