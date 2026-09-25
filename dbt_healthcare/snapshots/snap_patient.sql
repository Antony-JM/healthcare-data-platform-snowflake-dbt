{% snapshot snap_patient %}
{{
  config(
    target_schema='SNAPSHOT',
    unique_key='patient_id',
    strategy='check',
    check_cols=['address','city','postcode','patient_type']
  )
}}
select * from {{ ref('stg_patients') }}
{% endsnapshot %}
