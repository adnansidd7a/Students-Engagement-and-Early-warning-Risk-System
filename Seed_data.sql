 Seed Data Insertions

-- Insert Students
INSERT INTO students VALUES (1, 'Alex Mercer', 'alex.m@univ.edu', 'Mathematics', 2024);
INSERT INTO students VALUES (2, 'Bella Swan', 'bella.s@univ.edu', 'Applied Math', 2024);
INSERT INTO students VALUES (3, 'Charlie Brown', 'charlie.b@univ.edu', 'Statistics', 2025);
INSERT INTO students VALUES (4, 'Diana Prince', 'diana.p@univ.edu', 'Mathematics', 2023);
INSERT INTO students VALUES (5, 'Ethan Hunt', 'ethan.h@univ.edu', 'Computer Science', 2025);

-- Insert Courses
INSERT INTO courses VALUES (101, 'Calculus III', 'Mathematics', 'Dr. Euler', 'Fall 2026');
INSERT INTO courses VALUES (102, 'Linear Algebra', 'Mathematics', 'Dr. Gauss', 'Fall 2026');

-- Insert Enrollments
INSERT INTO enrollments VALUES (1, 1, 101, NULL, 'Active');
INSERT INTO enrollments VALUES (2, 2, 101, NULL, 'Active');
INSERT INTO enrollments VALUES (3, 3, 101, NULL, 'Active');
INSERT INTO enrollments VALUES (4, 4, 101, NULL, 'Active');
INSERT INTO enrollments VALUES (5, 5, 101, NULL, 'Active');

-- Insert Assessments
INSERT INTO assessments VALUES (201, 101, 'Quiz 1: Partial Derivatives', 100, '2026-09-10', 0.20);
INSERT INTO assessments VALUES (202, 101, 'Midterm Exam', 100, '2026-10-15', 0.40);

-- Insert Submissions
-- Student 1 & 4 perform well; Student 3 performs low; Student 5 submits late
INSERT INTO submissions VALUES (1, 201, 1, 92, '2026-09-09 14:00:00', 0);
INSERT INTO submissions VALUES (2, 201, 2, 85, '2026-09-10 11:30:00', 0);
INSERT INTO submissions VALUES (3, 201, 3, 45, '2026-09-10 23:50:00', 0); -- Low score
INSERT INTO submissions VALUES (4, 201, 4, 98, '2026-09-08 09:15:00', 0);
INSERT INTO submissions VALUES (5, 201, 5, 55, '2026-09-11 10:00:00', 1); -- Late & Low

-- Insert Activity Logs (LMS Engagement)
INSERT INTO activity_logs VALUES (1, 1, 101, '2026-09-05', 120, 3);
INSERT INTO activity_logs VALUES (2, 2, 101, '2026-09-05', 90, 1);
INSERT INTO activity_logs VALUES (3, 3, 101, '2026-09-05', 15, 0);  -- Low activity
INSERT INTO activity_logs VALUES (4, 4, 101, '2026-09-05', 150, 5);
INSERT INTO activity_logs VALUES (5, 5, 101, '2026-09-05', 25, 0);  -- Low activity