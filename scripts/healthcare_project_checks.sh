#!/usr/bin/env bash
set -euo pipefail

echo "== Git =="
git --version

echo

echo "== Python =="
python3 --version

echo

echo "== Project =="
test -f README.md && echo "README.md: OK"
test -f dbt_healthcare/dbt_project.yml && echo "dbt_project.yml: OK"
test -d data && echo "data/: OK"
test -d snowflake && echo "snowflake/: OK"

echo

echo "== Expected domains =="
for f in patients providers insurance appointments clinical_records claims billing payments doctor_assignments; do
  test -f "data/$f.csv" && echo "$f.csv: OK" || echo "$f.csv: MISSING"
done
