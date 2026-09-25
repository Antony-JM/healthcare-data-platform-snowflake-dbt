import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data"

EXPECTED = {
    "patients.csv": 50,
    "providers.csv": 4,
    "insurance.csv": 50,
    "appointments.csv": 100,
    "clinical_records.csv": 100,
    "claims.csv": 120,
    "billing.csv": 120,
    "payments.csv": 110,
    "doctor_assignments.csv": 60,
}


def read(name):
    with (DATA / name).open(newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def main() -> int:
    errors = []
    for name, expected in EXPECTED.items():
        rows = read(name)
        if len(rows) != expected:
            errors.append(f"{name}: expected {expected} rows, found {len(rows)}")

    patients = {r["patient_id"] for r in read("patients.csv")}
    providers = {r["provider_id"] for r in read("providers.csv")}

    for name in ["appointments.csv", "claims.csv", "clinical_records.csv", "doctor_assignments.csv"]:
        for row in read(name):
            if row["patient_id"] not in patients:
                errors.append(f"{name}: patient_id {row['patient_id']} does not exist")
            if row["provider_id"] not in providers:
                errors.append(f"{name}: provider_id {row['provider_id']} does not exist")

    for row in read("insurance.csv"):
        if row["patient_id"] not in patients:
            errors.append(f"insurance.csv: patient_id {row['patient_id']} does not exist")

    claims = {r["claim_id"] for r in read("claims.csv")}
    for name in ["billing.csv", "payments.csv"]:
        for row in read(name):
            if row["claim_id"] not in claims:
                errors.append(f"{name}: claim_id {row['claim_id']} does not exist")

    if errors:
        print("SOURCE DATA VALIDATION FAILED")
        for e in errors:
            print(f"- {e}")
        return 1

    print("SOURCE DATA VALIDATION PASSED")
    for name, expected in EXPECTED.items():
        print(f"- {name}: {expected} rows")
    print(f"- patient foreign keys: OK")
    print(f"- provider foreign keys: OK")
    print(f"- claim foreign keys: OK")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
