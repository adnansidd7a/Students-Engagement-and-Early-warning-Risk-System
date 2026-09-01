import sqlite3

def init_db():
    conn = sqlite3.connect("sewrs.db")
    cursor = conn.cursor()
    
    with open("schema.sql", "r") as f:
        cursor.executescript(f.read())
        
    with open("seed_data.sql", "r") as f:
        cursor.executescript(f.read())
        
    conn.commit()
    conn.close()
    print("Database initialized and seeded successfully.")

def run_risk_analysis():
    conn = sqlite3.connect("sewrs.db")
    cursor = conn.cursor()
    
    query = """
    SELECT 
        s.student_id,
        s.name,
        c.title AS course,
        sub.score,
        sub.is_late,
        COALESCE(SUM(al.platform_time_mins), 0) AS total_lms_mins
    FROM students s
    JOIN submissions sub ON s.student_id = sub.student_id
    JOIN assessments a ON sub.assessment_id = a.assessment_id
    JOIN courses c ON a.course_id = c.course_id
    LEFT JOIN activity_logs al ON s.student_id = al.student_id
    GROUP BY s.student_id, s.name, c.title, sub.score, sub.is_late;
    """
    
    cursor.execute(query)
    results = cursor.fetchall()
    
    print("\n--- AT-RISK STUDENT REPORT ---")
    print(f"{'ID':<4} | {'Name':<15} | {'Course':<15} | {'Score':<6} | {'Late':<5} | {'LMS Mins':<8}")
    print("-" * 65)
    for row in results:
        print(f"{row[0]:<4} | {row[1]:<15} | {row[2]:<15} | {row[3]:<6} | {row[4]:<5} | {row[5]:<8}")
        
    conn.close()

if __name__ == "__main__":
    init_db()
    run_risk_analysis()