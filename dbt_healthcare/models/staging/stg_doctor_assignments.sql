select
  assignment_id, patient_id, provider_id, effective_date, assignment_type
from {{ source('raw','doctor_assignments') }}
