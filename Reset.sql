-- ============================================================
-- Job Board & Career Portal - Reset Script (SQLite / Programiz)
-- Drop in reverse dependency order to respect FK constraints
-- ============================================================
 
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS SavedJobs;
DROP TABLE IF EXISTS Interviews;
DROP TABLE IF EXISTS Applications;
DROP TABLE IF EXISTS Jobs;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS JobSeekers;
DROP TABLE IF EXISTS Employers;
DROP TABLE IF EXISTS Users;
 