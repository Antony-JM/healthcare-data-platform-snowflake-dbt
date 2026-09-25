{{ config(materialized='incremental', unique_key='billing_id', incremental_strategy='merge') }}

select
    billing_id,
    claim_id,
    patient_id,
    billing_date,
    billed_amount,
    billing_status,
    current_timestamp() as dbt_loaded_at
from {{ ref('stg_billing') }}

{% if is_incremental() %}
where ingested_at > (select coalesce(max(dbt_loaded_at), '1900-01-01') from {{ this }})
{% endif %}
