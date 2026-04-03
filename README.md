# Job Board & Career Portal — Database Project
A relational database project for a Job Board and Career Portal application, built as part of a Database Management Systems course. Designed and implemented using SQLite, compatible with the [Programiz Online SQL Compiler](https://www.programiz.com/sql/online-compiler).

## Project Overview
This database models the complete lifecycle of a job portal — from employer registration and job posting, through candidate applications and interviews, to employer reviews. The schema consists of 9 tables normalized to Third Normal Form (3NF).

## Repository Structure
```
job-board-career-portal-dB/
├── sql/
│   ├── schema.sql
│   ├── sample_data.sql
│   └── reset.sql
├── diagrams/
│   └── er_diagram.pdf
├── report/
│   └── Job_Board_Database_Project.pdf
└── README.md
```

## Database Schema

| Table | Description |
|---|---|
| `Users`     | Base table for all user accounts (JobSeeker, Employer, Admin) |
| `Employers` | Extends Users — stores company profile data |
| `JobSeekers`| Extends Users — stores seeker profile, skills, and education |
| `Categories`| Lookup table for job categories |
| `Jobs`      | Job listings posted by employers |
| `Applications` | Applications submitted by job seekers |
| `Interviews` | Interview scheduling and outcome per application |
| `SavedJobs` | Junction table — seekers bookmarking jobs (M:M) |
| `Reviews` | Junction table — seekers reviewing employers (M:M) |

## How to Run (Programiz)
1. Open [https://www.programiz.com/sql/online-compiler](https://www.programiz.com/sql/online-compiler)
2. Clear the default content in the editor by dropping the table
3. Copy the full contents of `sql/schema.sql` and run it
4. Copy the full contents of `sql/sample_data.sql` and run it
5. Write and run any SELECT queries to explore the data

**To reset the database**, run `sql/reset.sql` first, then re-run schema and sample data.
> **Note:** SQLite does not enforce foreign keys by default. If you want FK enforcement, add `PRAGMA foreign_keys = ON;` at the top of your session before running the schema.

## Sample Queries
```sql
-- Query 1: All Open Jobs with Employer and Category
SELECT j.title, e.company_name, c.category_name,
       j.job_type, j.salary_min, j.salary_max, j.location
FROM Jobs j
JOIN Employers e  ON j.employer_id = e.employer_id
JOIN Categories c ON j.category_id = c.category_id
WHERE j.status = 'Open'
ORDER BY j.posted_at DESC;
```
```sql
-- Query 2: All Applications with Seeker Name and Job Title
SELECT u.full_name AS seeker_name,
       j.title     AS job_title,
       e.company_name,
       a.status,
       a.applied_at
FROM Applications a
JOIN JobSeekers js ON a.seeker_id = js.seeker_id
JOIN Users u       ON js.user_id  = u.user_id
JOIN Jobs j        ON a.job_id    = j.job_id
JOIN Employers e   ON j.employer_id = e.employer_id
ORDER BY a.applied_at DESC;
```
```sql
-- Query 3: Shortlisted Applicants with Interview Details
SELECT u.full_name, j.title, i.scheduled_at, i.mode, i.outcome
FROM Interviews i
JOIN Applications a ON i.application_id = a.application_id
JOIN JobSeekers js  ON a.seeker_id = js.seeker_id
JOIN Users u        ON js.user_id  = u.user_id
JOIN Jobs j         ON a.job_id    = j.job_id
WHERE a.status = 'Shortlisted';
```
```sql
-- Query 4: Average Employer Rating with Review Count
SELECT e.company_name,
       ROUND(AVG(r.rating), 2) AS avg_rating,
       COUNT(r.review_id)      AS total_reviews
FROM Reviews r
JOIN Employers e ON r.employer_id = e.employer_id
GROUP BY e.company_name
ORDER BY avg_rating DESC;
```
```sql
-- Query 5: Jobs Saved by a Specific Seeker
SELECT u.full_name AS seeker,
       j.title, e.company_name, sj.saved_at
FROM SavedJobs sj
JOIN JobSeekers js ON sj.seeker_id = js.seeker_id
JOIN Users u       ON js.user_id   = u.user_id
JOIN Jobs j        ON sj.job_id    = j.job_id
JOIN Employers e   ON j.employer_id = e.employer_id
WHERE u.full_name = 'Bob Martinez';
```
## Normalization
All tables are normalized to **3NF**:
- **1NF** — All columns hold atomic values; no repeating groups
- **2NF** — No partial dependencies (all PKs are single-column surrogates)
- **3NF** — No transitive dependencies (e.g. employer location is stored in `Employers`, not in `Jobs`)

## Key Design Decisions
- **User inheritance pattern** — A single `Users` table handles authentication for all roles. `Employers` and `JobSeekers` extend it via a 1:1 relationship, keeping login logic simple and role-specific data separated.
- **CHECK constraints** — Used on `role`, `job_type`, `status`, `mode`, `outcome`, and `rating` to enforce valid values at the database level.
- **UNIQUE constraints as business rules** — A seeker can only apply to a job once (`UNIQUE(job_id, seeker_id)`) and review an employer once (`UNIQUE(seeker_id, employer_id)`).
- **Salary stored as a range** — `salary_min` and `salary_max` allow range-based filtering without string parsing.
- **Junction tables** — `SavedJobs` and `Reviews` resolve M:M relationships cleanly while also capturing metadata (timestamps, ratings).

## Tech Stack

| Item | Detail |
|---|---|
| Database | SQLite |
| SQL Compiler | Programiz Online Compiler |
| Report Format | PDF (.pdf) |

## Course Information
**Student Name:** Sadaf Shiraz Kamal
**Course:** Database Management Systems  
**Project:** Final Project — Database-Backed Application  
**Track:** Independent Project
