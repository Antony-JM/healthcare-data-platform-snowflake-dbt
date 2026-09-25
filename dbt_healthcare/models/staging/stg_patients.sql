with ranked as (
    select *,
           row_number() over (partition by patient_id order by ingested_at desc) as rn
    from {{ source('raw','patients') }}
)
select
    patient_id,
    trim(first_name) as first_name,
    trim(last_name) as last_name,
    date_of_birth,
    upper(gender) as gender,
    trim(address) as address,
    trim(city) as city,
    upper(country) as country,
    upper(postcode) as postcode,
    patient_type,
    created_date,
    ingested_at
from ranked
where rn = 1
