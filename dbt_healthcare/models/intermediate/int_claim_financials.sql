select
    c.claim_id,
    c.patient_id,
    c.provider_id,
    c.service_date,
    c.claim_status,
    c.billed_amount,
    c.paid_amount,
    c.balance_amount,
    coalesce(sum(p.payment_amount),0) as payment_transactions
from {{ ref('stg_claims') }} c
left join {{ ref('stg_payments') }} p
  on c.claim_id = p.claim_id
group by 1,2,3,4,5,6,7,8
