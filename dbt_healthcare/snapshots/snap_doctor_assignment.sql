{% snapshot snap_doctor_assignment %}
{{
  config(
    target_schema='SNAPSHOT',
    unique_key='assignment_id',
    strategy='check',
    check_cols=['provider_id','assignment_type','effective_date']
  )
}}
select * from {{ ref('stg_doctor_assignments') }}
{% endsnapshot %}
