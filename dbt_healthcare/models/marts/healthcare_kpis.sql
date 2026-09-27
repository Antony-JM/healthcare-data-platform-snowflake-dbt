{{ config(
    materialized='table'
) }}

with patient_metrics as (

    select
        count(*) as total_patients
    from {{ ref('dim_patient') }}

),

claim_metrics as (

    select
        count(*) as total_claims,
        sum(billed_amount) as total_billed,
        sum(paid_amount) as total_paid,
        sum(balance_amount) as total_balance,
        count_if(claim_status = 'Denied') as denied_claims
    from {{ ref('fct_claim') }}

),

appointment_metrics as (

    select
        count(*) as total_appointments,
        count_if(status = 'Completed') as completed_appointments,
        count_if(status = 'No Show') as no_show_appointments,
        count_if(status = 'Cancelled') as cancelled_appointments
    from {{ ref('fct_appointment') }}

),

payment_metrics as (

    select
        count(*) as total_payment_transactions,
        sum(payment_amount) as total_payment_transaction_amount
    from {{ ref('fct_payment') }}

)

select

    p.total_patients,

    a.total_appointments,
    a.completed_appointments,
    a.no_show_appointments,
    a.cancelled_appointments,

    c.total_claims,
    c.total_billed,
    c.total_paid,
    c.total_balance,
    c.denied_claims,

    pay.total_payment_transactions,
    pay.total_payment_transaction_amount,

    round(
        c.denied_claims
        / nullif(c.total_claims, 0) * 100,
        2
    ) as denial_rate_pct,

    round(
        a.no_show_appointments
        / nullif(a.total_appointments, 0) * 100,
        2
    ) as no_show_rate_pct,

    round(
        c.total_paid
        / nullif(c.total_billed, 0) * 100,
        2
    ) as collection_rate_pct,

    current_timestamp() as generated_at

from patient_metrics p
cross join claim_metrics c
cross join appointment_metrics a
cross join payment_metrics pay