# Source data correction — doctor assignment provider IDs

The supplied synthetic `doctor_assignments.csv` initially used provider IDs such as `P001` while the provider master used `P1001`.

For the clean baseline, we standardised the assignment source IDs to the provider master format:

- P001 -> P1001
- P002 -> P1002
- P003 -> P1003
- P004 -> P1004

This gives us a valid baseline. During the QA phase we will introduce a controlled invalid foreign key in a separate test fixture to demonstrate how dbt catches it, rather than contaminating the production-like baseline.
