select
    provider_id,
    trim(provider_name) as provider_name,
    trim(specialty) as specialty,
    trim(facility) as facility,
    ingested_at
from {{ source('raw','providers') }}
