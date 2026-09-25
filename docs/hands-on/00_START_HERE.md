# Hands-On Build: Start Here

This repository is built to be implemented step by step in a Snowflake trial + local dbt environment and then published to GitHub.

## Working rule

Do not blindly copy/paste the whole project and call it finished. We will execute each phase, validate it, capture evidence, and update the README as we go.

## The two-day implementation path

### Day 1
1. GitHub + local repository
2. Snowflake account and cost controls
3. Snowflake DEV environment
4. RAW tables, stages and file formats
5. Load synthetic source data
6. Build dbt connection
7. Staging models + tests
8. Intermediate models
9. Star-schema marts
10. First source-to-target reconciliation

### Day 2
11. dbt snapshots / SCD Type 2
12. Incremental claims and billing
13. Snowflake Streams + Tasks + MERGE
14. Audit/control framework
15. RBAC + masking
16. DEV / QA / PROD promotion pattern
17. ADF orchestration simulation
18. Power BI semantic model + dashboard
19. dbt CI with GitHub Actions
20. README, architecture diagram, screenshots and interview walkthrough

## What counts as 'done'

Every important component must have:
- code in the repository
- a validation query/test
- a short explanation in the README or docs
- evidence captured as a screenshot or command output where practical

## Source data

All files under `data/` are synthetic and safe for this portfolio project. Never add real patient data to this repository.
