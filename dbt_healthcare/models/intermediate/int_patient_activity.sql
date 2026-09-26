with appointment_activity as (

    select
        patient_id,
        count(distinct appointment_id) as appointment_count,
        count_if(status = 'Completed') as completed_appointment_count,
        count_if(status = 'No Show') as no_show_appointment_count,
        count_if(status = 'Cancelled') as cancelled_appointment_count

    from {{ ref('stg_appointments') }}

    group by patient_id

),

claim_activity as (

    select
        patient_id,
        count(distinct claim_id) as claim_count,
        sum(billed_amount) as total_billed_amount,
        sum(paid_amount) as total_paid_amount,
        sum(balance_amount) as total_balance_amount

    from {{ ref('stg_claims') }}

    group by patient_id

),

clinical_activity as (

    select
        patient_id,
        count(distinct clinical_id) as clinical_record_count

    from {{ ref('stg_clinical_records') }}

    group by patient_id

)

select
    p.patient_id,

    coalesce(a.appointment_count, 0) as appointment_count,
    coalesce(a.completed_appointment_count, 0) as completed_appointment_count,
    coalesce(a.no_show_appointment_count, 0) as no_show_appointment_count,
    coalesce(a.cancelled_appointment_count, 0) as cancelled_appointment_count,

    coalesce(c.claim_count, 0) as claim_count,
    coalesce(c.total_billed_amount, 0) as total_billed_amount,
    coalesce(c.total_paid_amount, 0) as total_paid_amount,
    coalesce(c.total_balance_amount, 0) as total_balance_amount,

    coalesce(cr.clinical_record_count, 0) as clinical_record_count

from {{ ref('stg_patients') }} p

left join appointment_activity a
    on p.patient_id = a.patient_id

left join claim_activity c
    on p.patient_id = c.patient_id

left join clinical_activity cr
    on p.patient_id = cr.patient_id