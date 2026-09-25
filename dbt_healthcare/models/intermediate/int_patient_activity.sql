select
    p.patient_id,
    count(distinct a.appointment_id) as appointment_count,
    count(distinct c.claim_id) as claim_count,
    count(distinct cr.clinical_id) as clinical_record_count,
    coalesce(sum(c.billed_amount),0) as total_billed,
    coalesce(sum(c.paid_amount),0) as total_paid
from {{ ref('stg_patients') }} p
left join {{ ref('stg_appointments') }} a on p.patient_id = a.patient_id
left join {{ ref('stg_claims') }} c on p.patient_id = c.patient_id
left join {{ ref('stg_clinical_records') }} cr on p.patient_id = cr.patient_id
group by 1
