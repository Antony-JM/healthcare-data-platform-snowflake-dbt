select provider_id, provider_name, specialty, facility
from {{ ref('stg_providers') }}
