{{ config(
    materialized='incremental',
    unique_key='claim_id',
    incremental_strategy='merge'
) }}

WITH latest_source_claims AS (

    SELECT
        claim_id,
        patient_id,
        provider_id,
        service_date,
        claim_status,
        billed_amount,
        paid_amount,
        balance_amount,
        ingested_at
    FROM {{ ref('stg_claims') }}

    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY claim_id
        ORDER BY ingested_at DESC
    ) = 1

)

{% if is_incremental() %}

SELECT
    s.claim_id,
    s.patient_id,
    s.provider_id,
    s.service_date,
    s.claim_status,
    s.billed_amount,
    s.paid_amount,
    s.balance_amount,
    s.ingested_at
FROM latest_source_claims s
LEFT JOIN (
    SELECT
        claim_id,
        MAX(ingested_at) AS max_ingested_at
    FROM {{ this }}
    GROUP BY claim_id
) t
    ON s.claim_id = t.claim_id
WHERE t.claim_id IS NULL
   OR s.ingested_at > t.max_ingested_at

{% else %}

SELECT
    claim_id,
    patient_id,
    provider_id,
    service_date,
    claim_status,
    billed_amount,
    paid_amount,
    balance_amount,
    ingested_at
FROM latest_source_claims

{% endif %}
