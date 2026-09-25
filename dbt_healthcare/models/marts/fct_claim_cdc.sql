{{ config(
    materialized='incremental',
    unique_key='claim_id',
    incremental_strategy='merge'
) }}

select
    claim_id,
    patient_id,
    provider_id,
    service_date,
    claim_status,
    billed_amount,
    paid_amount,
    balance_amount,
    ingested_at
from {{ ref('stg_claims') }}

{% if is_incremental() %}
where ingested_at >= (
    select coalesce(max(ingested_at), '1900-01-01'::timestamp_ntz) from {{ this }}
)
{% endif %}
