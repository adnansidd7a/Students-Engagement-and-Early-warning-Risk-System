-- Representative SQL Queries for SE-EWRS

-- 1. At-Risk Student Identification Query
-- Flags students whose scores are below 60% or submitted late
SELECT 
    s.student_id,
    s.name,
    c.title AS course_title,
    sub.score,
    a.max_score,
    ROUND((sub.score / a.max_score) * 100, 2) AS percentage_score,
    sub.is_late,
    CASE 
        WHEN (sub.score / a.max_score) < 0.50 THEN 'High Risk'
        WHEN (sub.score / a.max_score) < 0.65 OR sub.is_late = 1 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS calculated_risk
FROM submissions sub
JOIN assessments a ON sub.assessment_id = a.assessment_id
JOIN courses c ON a.course_id = c.course_id
JOIN students s ON sub.student_id = s.student_id
ORDER BY percentage_score ASC;

-- 2. Engagement Correlation Query
-- Aggregates LMS time vs quiz performance per student
SELECT 
    st.name,
    COALESCE(SUM(al.platform_time_mins), 0) AS total_lms_minutes,
    COALESCE(SUM(al.forum_posts), 0) AS total_posts,
    ROUND(AVG(sub.score), 2) AS avg_assessment_score
FROM students st
LEFT JOIN activity_logs al ON st.student_id = al.student_id
LEFT JOIN submissions sub ON st.student_id = sub.student_id
GROUP BY st.student_id, st.name
ORDER BY avg_assessment_score ASC;

-- 3. Trigger Insertion Simulation (Manual Risk Alert Population)
INSERT INTO risk_alerts (student_id, course_id, date_generated, risk_level, trigger_reason, status)
SELECT 
    sub.student_id,
    a.course_id,
    DATE('now'),
    'High',
    'Score dropped below critical threshold (50%)',
    'Pending'
FROM submissions sub
JOIN assessments a ON sub.assessment_id = a.assessment_id
WHERE (sub.score / a.max_score) < 0.50;