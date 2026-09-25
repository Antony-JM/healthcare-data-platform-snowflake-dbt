select
    patient_id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    address,
    city,
    country,
    postcode,
    patient_type,
    created_date
from {{ ref('stg_patients') }}
