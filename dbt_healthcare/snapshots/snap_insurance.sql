{% snapshot snap_insurance %}
{{
  config(
    target_schema='SNAPSHOT',
    unique_key='insurance_id',
    strategy='check',
    check_cols=['payer_name','policy_number','effective_date','expiry_date','status']
  )
}}
select * from {{ ref('stg_insurance') }}
{% endsnapshot %}
