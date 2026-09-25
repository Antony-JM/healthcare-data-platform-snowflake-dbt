{{ config(materialized='incremental', unique_key='patient_id', incremental_strategy='merge') }}

select * from {{ ref('stg_patients') }}

{% if is_incremental() %}
where ingested_at >= (select coalesce(max(ingested_at),'1900-01-01'::timestamp_ntz) from {{ this }})
{% endif %}
