{{ config(materialized='incremental', unique_key='claim_id', incremental_strategy='merge') }}

select
    c.claim_id,
    c.patient_id,
    c.provider_id,
    c.service_date,
    c.claim_status,
    c.billed_amount,
    c.paid_amount,
    c.balance_amount,
    current_timestamp() as dbt_loaded_at
from {{ ref('stg_claims') }} c

{% if is_incremental() %}
where c.ingested_at > (select coalesce(max(dbt_loaded_at), '1900-01-01') from {{ this }})
{% endif %}
