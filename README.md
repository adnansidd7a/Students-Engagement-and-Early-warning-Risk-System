# Student Engagement & Early Warning Risk System (SE-EWRS)

**Department:** Department of Mathematics  


## Project Overview
Traditional Learning Management Systems (LMS) collect vast amounts of student activity data—such as login frequencies, assignment submission times, and quiz scores—but fail to translate raw data into timely instructional insights. Instructors typically identify struggling students only after major exams or course dropouts occur, when it is too late to intervene. 

This project addresses the gap by building a relational database system that processes real-time student performance and engagement metrics to automatically calculate risk scores and alert educators before academic failure happens.

---

## 1. Objectives and Scope

### Objectives
- Design and implement a relational database schema to centralize student academic performance and LMS interaction records.
- Develop automated SQL analytical queries and database triggers to compute student risk scores based on participation levels and grade trajectories.
- Provide instructors with systematic early-warning notifications to facilitate targeted academic interventions.

### Scope
- **In Scope:** Tracking student profiles, course enrollments, assessment performance, LMS activity logs, risk threshold evaluation, and intervention record management.
- **Out of Scope:** Building full web-based front-end applications, processing streaming video analytics, or constructing automated grading engines.

---

## 2. Users and Major Operations

### Primary Users
- Instructors
- Teaching Assistants
- Academic Advisors
- Department Chairs

### Major System Operations
1. **Data Ingestion:** Ingesting daily user logs, submission timestamps, and assessment scores into normalized tables.
2. **Risk Assessment Execution:** Running automated evaluation queries that cross-reference attendance rates and submission deadlines against defined risk parameters.
3. **Intervention Tracking:** Logging advisor outreach, tutoring referrals, and resolution updates for flagged students.
4. **Cohort Reporting:** Generating aggregated performance and retention views across departments and academic terms.

---

## How to Run

1. **Set up SQLite / PostgreSQL Database:**
   ```bash
   sqlite3 sewrs.db < schema.sql
   sqlite3 sewrs.db < seed_data.sql
   sqlite3 sewrs.db < queries.sql