-- ============================================================
-- Job Board & Career Portal - Schema (SQLite / Programiz)
-- ============================================================
 
-- 1. Users (base table for all user types)
CREATE TABLE Users (
    user_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name   TEXT    NOT NULL,
    email       TEXT    NOT NULL UNIQUE,
    password    TEXT    NOT NULL,
    phone       TEXT,
    role        TEXT    NOT NULL CHECK(role IN ('JobSeeker','Employer','Admin')),
    created_at  TEXT    DEFAULT (datetime('now'))
);
 
-- 2. Employers (extends Users)
CREATE TABLE Employers (
    employer_id  INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id      INTEGER NOT NULL UNIQUE,
    company_name TEXT    NOT NULL,
    industry     TEXT,
    website      TEXT,
    city         TEXT,
    country      TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
 
-- 3. JobSeekers (extends Users)
CREATE TABLE JobSeekers (
    seeker_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id     INTEGER NOT NULL UNIQUE,
    resume_url  TEXT,
    skills      TEXT,
    experience_years INTEGER DEFAULT 0,
    education   TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
 
-- 4. Categories
CREATE TABLE Categories (
    category_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    category_name TEXT NOT NULL UNIQUE,
    description   TEXT
);
 
-- 5. Jobs
CREATE TABLE Jobs (
    job_id        INTEGER PRIMARY KEY AUTOINCREMENT,
    employer_id   INTEGER NOT NULL,
    category_id   INTEGER NOT NULL,
    title         TEXT    NOT NULL,
    description   TEXT    NOT NULL,
    location      TEXT,
    job_type      TEXT    CHECK(job_type IN ('Full-Time','Part-Time','Contract','Internship')),
    salary_min    REAL,
    salary_max    REAL,
    status        TEXT    DEFAULT 'Open' CHECK(status IN ('Open','Closed','Paused')),
    posted_at     TEXT    DEFAULT (datetime('now')),
    deadline      TEXT,
    FOREIGN KEY (employer_id) REFERENCES Employers(employer_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
 
-- 6. Applications
CREATE TABLE Applications (
    application_id INTEGER PRIMARY KEY AUTOINCREMENT,
    job_id         INTEGER NOT NULL,
    seeker_id      INTEGER NOT NULL,
    cover_letter   TEXT,
    status         TEXT DEFAULT 'Pending' CHECK(status IN ('Pending','Reviewed','Shortlisted','Rejected','Hired')),
    applied_at     TEXT DEFAULT (datetime('now')),
    UNIQUE(job_id, seeker_id),
    FOREIGN KEY (job_id)     REFERENCES Jobs(job_id),
    FOREIGN KEY (seeker_id)  REFERENCES JobSeekers(seeker_id)
);
 
-- 7. Interviews
CREATE TABLE Interviews (
    interview_id    INTEGER PRIMARY KEY AUTOINCREMENT,
    application_id  INTEGER NOT NULL UNIQUE,
    scheduled_at    TEXT    NOT NULL,
    mode            TEXT    CHECK(mode IN ('In-Person','Phone','Video')),
    notes           TEXT,
    outcome         TEXT    CHECK(outcome IN ('Pass','Fail','No Show','Pending')) DEFAULT 'Pending',
    FOREIGN KEY (application_id) REFERENCES Applications(application_id)
);
 
-- 8. SavedJobs (bookmarks)
CREATE TABLE SavedJobs (
    saved_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    seeker_id  INTEGER NOT NULL,
    job_id     INTEGER NOT NULL,
    saved_at   TEXT DEFAULT (datetime('now')),
    UNIQUE(seeker_id, job_id),
    FOREIGN KEY (seeker_id) REFERENCES JobSeekers(seeker_id),
    FOREIGN KEY (job_id)    REFERENCES Jobs(job_id)
);
 
-- 9. Reviews (seeker reviews employer)
CREATE TABLE Reviews (
    review_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    seeker_id   INTEGER NOT NULL,
    employer_id INTEGER NOT NULL,
    rating      INTEGER CHECK(rating BETWEEN 1 AND 5),
    comment     TEXT,
    reviewed_at TEXT DEFAULT (datetime('now')),
    UNIQUE(seeker_id, employer_id),
    FOREIGN KEY (seeker_id)   REFERENCES JobSeekers(seeker_id),
    FOREIGN KEY (employer_id) REFERENCES Employers(employer_id)
);