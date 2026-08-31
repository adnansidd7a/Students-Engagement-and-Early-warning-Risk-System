

###schema.sql

sql Database Schema for Student Engagement & Early Warning Risk System

DROP TABLE IF EXISTS risk_alerts;
DROP TABLE IF EXISTS activity_logs;
DROP TABLE IF EXISTS submissions;
DROP TABLE IF EXISTS assessments;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;

-- 1. Students Entity
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    major VARCHAR(50) NOT NULL,
    enrollment_year INTEGER NOT NULL
);

-- 2. Courses Entity
CREATE TABLE courses (
    course_id INTEGER PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    instructor VARCHAR(100) NOT NULL,
    academic_term VARCHAR(20) NOT NULL
);

-- 3. Enrollments Associative Entity
CREATE TABLE enrollments (
    enrollment_id INTEGER PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    final_grade REAL,
    status VARCHAR(20) DEFAULT 'Active' CHECK (status IN ('Active', 'Dropped', 'Completed')),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    CONSTRAINT unique_enrollment UNIQUE (student_id, course_id)
);

-- 4. Assessments Entity
CREATE TABLE assessments (
    assessment_id INTEGER PRIMARY KEY,
    course_id INTEGER NOT NULL,
    title VARCHAR(100) NOT NULL,
    max_score REAL NOT NULL CHECK (max_score > 0),
    due_date DATE NOT NULL,
    weight REAL NOT NULL CHECK (weight > 0 AND weight <= 1.0),
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

-- 5. Submissions Entity
CREATE TABLE submissions (
    submission_id INTEGER PRIMARY KEY,
    assessment_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    score REAL CHECK (score >= 0),
    submission_timestamp DATETIME NOT NULL,
    is_late INTEGER DEFAULT 0 CHECK (is_late IN (0, 1)),
    FOREIGN KEY (assessment_id) REFERENCES assessments(assessment_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);

-- 6. Activity Logs Entity
CREATE TABLE activity_logs (
    log_id INTEGER PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    activity_date DATE NOT NULL,
    platform_time_mins INTEGER DEFAULT 0 CHECK (platform_time_mins >= 0),
    forum_posts INTEGER DEFAULT 0 CHECK (forum_posts >= 0),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

-- 7. Risk Alerts Entity
CREATE TABLE risk_alerts (
    alert_id INTEGER PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    date_generated DATE NOT NULL,
    risk_level VARCHAR(10) CHECK (risk_level IN ('Low', 'Medium', 'High')),
    trigger_reason VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'In Progress', 'Resolved')),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);