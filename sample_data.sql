-- ============================================================
-- Job Board & Career Portal - Sample Data (SQLite / Programiz)
-- ============================================================
 
-- Users
INSERT INTO Users (full_name, email, password, phone, role) VALUES
('Alice Johnson',   'alice@email.com',    'hashed_pw_1', '555-0101', 'JobSeeker'),
('Bob Martinez',    'bob@email.com',      'hashed_pw_2', '555-0102', 'JobSeeker'),
('Carol White',     'carol@email.com',    'hashed_pw_3', '555-0103', 'JobSeeker'),
('David Kim',       'david@email.com',    'hashed_pw_4', '555-0104', 'JobSeeker'),
('Eva Patel',       'eva@email.com',      'hashed_pw_5', '555-0105', 'JobSeeker'),
('TechCorp Inc',    'hr@techcorp.com',    'hashed_pw_6', '555-0201', 'Employer'),
('FinancePro LLC',  'jobs@financepro.com','hashed_pw_7', '555-0202', 'Employer'),
('HealthPlus',      'recruit@hplus.com',  'hashed_pw_8', '555-0203', 'Employer'),
('Admin User',      'admin@portal.com',   'hashed_pw_9', NULL,       'Admin');
 
-- Employers
INSERT INTO Employers (user_id, company_name, industry, website, city, country) VALUES
(6, 'TechCorp Inc',   'Technology', 'https://techcorp.com',    'New York',  'USA'),
(7, 'FinancePro LLC', 'Finance',    'https://financepro.com',  'Chicago',   'USA'),
(8, 'HealthPlus',     'Healthcare', 'https://healthplus.com',  'Boston',    'USA');
 
-- JobSeekers
INSERT INTO JobSeekers (user_id, skills, experience_years, education, resume_url) VALUES
(1, 'Python, SQL, Django',          3, 'B.Sc Computer Science',  'https://resumes.io/alice'),
(2, 'Java, Spring Boot, AWS',       5, 'B.Sc Software Eng',      'https://resumes.io/bob'),
(3, 'Excel, Power BI, Accounting',  4, 'B.Sc Finance',           'https://resumes.io/carol'),
(4, 'Nursing, Patient Care, EMR',   2, 'B.S Nursing',            'https://resumes.io/david'),
(5, 'React, Node.js, TypeScript',   1, 'B.Sc IT',                'https://resumes.io/eva');
 
-- Categories
INSERT INTO Categories (category_name, description) VALUES
('Software Engineering', 'Development, architecture, and engineering roles'),
('Finance & Accounting', 'Financial analysis, accounting, and auditing roles'),
('Healthcare',           'Medical, nursing, and clinical roles'),
('Data Science',         'Analytics, ML, and data engineering roles'),
('Marketing',            'Digital marketing and brand management');
 
-- Jobs
INSERT INTO Jobs (employer_id, category_id, title, description, location, job_type, salary_min, salary_max, status, deadline) VALUES
(1, 1, 'Backend Python Developer',   'Build and maintain APIs using Django and PostgreSQL.',        'New York',  'Full-Time',   85000, 110000, 'Open',   '2025-06-30'),
(1, 4, 'Data Analyst',               'Analyze product data, build dashboards, write SQL reports.',  'Remote',    'Full-Time',   70000,  95000, 'Open',   '2025-07-15'),
(1, 1, 'Frontend React Developer',   'Build interactive UIs with React and TypeScript.',            'New York',  'Contract',    60000,  80000, 'Open',   '2025-06-20'),
(2, 2, 'Financial Analyst',          'Prepare financial reports and forecasting models.',           'Chicago',   'Full-Time',   75000, 100000, 'Open',   '2025-07-01'),
(2, 2, 'Accounting Intern',          'Assist accounting team with bookkeeping and reconciliation.', 'Chicago',   'Internship',  20000,  30000, 'Closed', '2025-05-01'),
(3, 3, 'Registered Nurse',           'Provide patient care in our inpatient medical ward.',         'Boston',    'Full-Time',   65000,  85000, 'Open',   '2025-07-31'),
(3, 3, 'Medical Records Specialist', 'Maintain accurate patient records using EMR systems.',        'Boston',    'Part-Time',   35000,  45000, 'Open',   '2025-08-01');
 
-- Applications
INSERT INTO Applications (job_id, seeker_id, cover_letter, status) VALUES
(1, 1, 'I have 3 years of Django experience and would love to join TechCorp.',  'Shortlisted'),
(1, 5, 'Eager to transition into backend, strong Python fundamentals.',         'Pending'),
(2, 1, 'Experienced with SQL and dashboards, ready to dive into analytics.',    'Reviewed'),
(3, 5, 'React and TypeScript are my primary stack. Portfolio attached.',        'Shortlisted'),
(4, 3, 'Four years in financial analysis, CFA Level 1 candidate.',              'Hired'),
(5, 3, 'Would like to gain more experience in accounting practices.',           'Rejected'),
(6, 4, 'Registered nurse with 2 years ICU experience.',                         'Shortlisted'),
(7, 4, 'Proficient with Epic EMR and medical record management.',               'Pending');
 
-- Interviews
INSERT INTO Interviews (application_id, scheduled_at, mode, outcome) VALUES
(1, '2025-05-20 10:00:00', 'Video',     'Pass'),
(4, '2025-05-22 14:00:00', 'Video',     'Pass'),
(5, '2025-05-15 09:00:00', 'In-Person', 'Pass'),
(7, '2025-05-25 11:00:00', 'Phone',     'Pending');
 
-- SavedJobs
INSERT INTO SavedJobs (seeker_id, job_id) VALUES
(1, 4),
(2, 1),
(2, 2),
(3, 4),
(5, 1),
(5, 2);
 
-- Reviews
INSERT INTO Reviews (seeker_id, employer_id, rating, comment) VALUES
(3, 2, 5, 'Great onboarding and professional team at FinancePro.'),
(1, 1, 4, 'TechCorp has a strong engineering culture and fair interview process.'),
(4, 3, 4, 'HealthPlus was responsive and the hiring process was smooth.');