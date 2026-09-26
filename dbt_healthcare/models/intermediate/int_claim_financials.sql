with payment_summary as (

    select
        claim_id,
        count(distinct payment_id) as payment_transaction_count,
        coalesce(sum(payment_amount), 0) as payment_transaction_amount

    from {{ ref('stg_payments') }}

    group by claim_id

)

select
    c.claim_id,
    c.patient_id,
    c.provider_id,
    c.service_date,
    c.claim_status,

    c.billed_amount,
    c.paid_amount,
    c.balance_amount,

    coalesce(p.payment_transaction_count, 0)
        as payment_transaction_count,

    coalesce(p.payment_transaction_amount, 0)
        as payment_transaction_amount,

    round(
        c.billed_amount - c.paid_amount - c.balance_amount,
        2
    ) as source_financial_reconciliation_difference,

    round(
        c.billed_amount
        - coalesce(p.payment_transaction_amount, 0)
        - c.balance_amount,
        2
    ) as transaction_financial_difference,

    current_timestamp() as transformed_at

from {{ ref('stg_claims') }} c

left join payment_summary p
    on c.claim_id = p.claim_id