-- Advanced Query Example: GROUP BY and HAVING with Aggregations
-- This query demonstrates grouping and filtering of aggregated data

-- Analyze enrollment trends by department, semester and year
-- Find popular courses with high enrollment rates and good student performance

SELECT 
    d.DepartmentName,
    c.CourseCode,
    c.Title AS CourseTitle,
    cl.Semester,
    cl.Year,
    COUNT(e.EnrollmentID) AS EnrollmentCount,
    AVG(g.GradePoint) AS AverageGrade,
    -- Calculate percentage of students who passed (C or better)
    SUM(CASE WHEN g.GradeLetter IN ('A', 'B', 'C') THEN 1 ELSE 0 END) * 100.0 / COUNT(e.EnrollmentID) AS PassRate,
    -- Calculate percentage of withdrawals
    SUM(CASE WHEN g.GradeLetter = 'W' THEN 1 ELSE 0 END) * 100.0 / COUNT(e.EnrollmentID) AS WithdrawalRate
FROM 
    Departments d
    JOIN Courses c ON d.DepartmentID = c.DepartmentID
    JOIN Classes cl ON c.CourseID = cl.CourseID
    JOIN Enrollments e ON cl.ClassID = e.ClassID
    LEFT JOIN Grades g ON e.GradeID = g.GradeID
GROUP BY
    d.DepartmentName,
    c.CourseCode,
    c.Title,
    cl.Semester,
    cl.Year
HAVING 
    -- Only include courses with significant enrollment (at least 10 students)
    COUNT(e.EnrollmentID) >= 10
    -- And decent pass rates (at least 70%)
    AND (SUM(CASE WHEN g.GradeLetter IN ('A', 'B', 'C') THEN 1 ELSE 0 END) * 100.0 / COUNT(e.EnrollmentID)) >= 70
    -- And low withdrawal rates (less than 15%)
    AND (SUM(CASE WHEN g.GradeLetter = 'W' THEN 1 ELSE 0 END) * 100.0 / COUNT(e.EnrollmentID)) < 15
ORDER BY 
    cl.Year DESC,
    cl.Semester,
    EnrollmentCount DESC,
    AverageGrade DESC;

-- This query demonstrates:
-- 1. Complex grouping with GROUP BY on multiple columns
-- 2. Filtering aggregated results with HAVING
-- 3. Percentage calculations using CASE expressions
-- 4. Conditional aggregations for pass and withdrawal rates
-- 5. Multi-level sorting with mixed sort directions (DESC/ASC) 