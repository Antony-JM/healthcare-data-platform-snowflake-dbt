select *
from {{ ref('fct_claim') }}
where abs(coalesce(billed_amount,0) - coalesce(paid_amount,0) - coalesce(balance_amount,0)) > 0.01
