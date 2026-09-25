# Dimensional Data Model

```mermaid
erDiagram
    DIM_DATE ||--o{ FCT_CLAIM : service_date
    DIM_PATIENT ||--o{ FCT_CLAIM : patient_id
    DIM_PROVIDER ||--o{ FCT_CLAIM : provider_id
    DIM_PATIENT ||--o{ FCT_BILLING : patient_id
    DIM_PATIENT ||--o{ FCT_PAYMENT : patient_id
    DIM_PATIENT ||--o{ FCT_APPOINTMENT : patient_id
    DIM_PROVIDER ||--o{ FCT_APPOINTMENT : provider_id
    DIM_PATIENT ||--o{ FCT_CLINICAL_RECORD : patient_id
    DIM_PROVIDER ||--o{ FCT_CLINICAL_RECORD : provider_id
    DIM_PATIENT ||--o{ DIM_INSURANCE : patient_id
```

## Slowly changing dimensions
- Patient: Type 2 for address/city/postcode/patient type
- Insurance: Type 2 for payer/policy/status/effective dates
- Doctor assignment: Type 2 for patient-provider assignment history

## Fact grains
- Claim = one financial/administrative claim
- Billing = one billing transaction
- Payment = one payment transaction
- Appointment = one scheduled appointment
- Clinical record = one clinical event/record
