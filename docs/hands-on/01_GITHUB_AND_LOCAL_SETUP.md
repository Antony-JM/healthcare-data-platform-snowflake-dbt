# Phase 1 — GitHub + Local Setup

## Goal

Create the Git repository locally, make the first commit, then connect it to your GitHub repository.

## 1. Install/check Git

Run:

```bash
git --version
```

## 2. Choose the project directory

Unzip this project somewhere convenient. Example:

```bash
cd ~/Projects
unzip ~/Downloads/healthcare_snowflake_dbt_project.zip
cd healthcare_snowflake_dbt_project
```

Check the repository:

```bash
pwd
find . -maxdepth 2 -type f | sort | head -80
```

## 3. Initialise Git

```bash
git init
git branch -M main
git status
```

You should see the project files as untracked.

## 4. Review the ignore rules

```bash
cat .gitignore
```

Most important: credentials, `.env`, `profiles.yml`, dbt `target/`, and `dbt_packages/` must never be committed.

## 5. First commit

```bash
git add .
git status
git commit -m "chore: initialise healthcare snowflake dbt project"
```

## 6. Create an empty GitHub repository

Create a repository such as:

`healthcare-data-platform-snowflake-dbt`

For the cleanest first push, create it without adding another README, `.gitignore`, or license because those already exist locally.

## 7. Connect the remote

Replace `<YOUR_GITHUB_USERNAME>` with your username:

```bash
git remote add origin https://github.com/<YOUR_GITHUB_USERNAME>/healthcare-data-platform-snowflake-dbt.git
git remote -v
git push -u origin main
```

## 8. Evidence to capture

Take a screenshot of:
- the GitHub repository home page
- the first commit
- the project tree

We will later add Snowflake/dbt execution evidence to the README.

## Stop point

Do not move to Snowflake until:

```bash
git status
```

shows a clean working tree and your GitHub repository contains the project.
