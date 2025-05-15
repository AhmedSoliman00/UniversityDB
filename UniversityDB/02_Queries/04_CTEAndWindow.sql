-- Advanced Query Example: Common Table Expressions (CTEs) and Window Functions
-- This query demonstrates the use of CTEs and window functions for advanced analysis

-- Find top-performing students within each department along with their ranking
-- and how they compare to the department average

WITH StudentGrades AS (
    -- Calculate average grade point for each student across all their courses
    SELECT 
        s.StudentID,
        s.FirstName + ' ' + s.LastName AS StudentName,
        m.MajorName,
        d.DepartmentID,
        d.DepartmentName,
        COUNT(e.EnrollmentID) AS CoursesTaken,
        AVG(g.GradePoint) AS AverageGradePoint
    FROM 
        Students s
        JOIN Majors m ON s.MajorID = m.MajorID
        JOIN Departments d ON m.DepartmentID = d.DepartmentID
        JOIN Enrollments e ON s.StudentID = e.StudentID
        JOIN Classes cl ON e.ClassID = cl.ClassID
        JOIN Grades g ON e.GradeID = g.GradeID
    WHERE 
        -- Only include students with at least 3 completed courses
        g.GradeLetter <> 'W' -- Not withdrawn
    GROUP BY
        s.StudentID,
        s.FirstName,
        s.LastName,
        m.MajorName,
        d.DepartmentID,
        d.DepartmentName
    HAVING 
        COUNT(e.EnrollmentID) >= 3
),
DepartmentStats AS (
    -- Calculate department level statistics
    SELECT
        DepartmentID,
        DepartmentName,
        AVG(AverageGradePoint) AS DepartmentAverage,
        MIN(AverageGradePoint) AS DepartmentMinGPA,
        MAX(AverageGradePoint) AS DepartmentMaxGPA
    FROM 
        StudentGrades
    GROUP BY
        DepartmentID,
        DepartmentName
)
SELECT
    sg.DepartmentName,
    sg.StudentName,
    sg.MajorName,
    sg.CoursesTaken,
    sg.AverageGradePoint,
    -- Format to show letter grade equivalent
    CASE 
        WHEN sg.AverageGradePoint >= 4.0 THEN 'A'
        WHEN sg.AverageGradePoint >= 3.0 THEN 'B'
        WHEN sg.AverageGradePoint >= 2.0 THEN 'C'
        WHEN sg.AverageGradePoint >= 1.0 THEN 'D'
        ELSE 'F'
    END AS LetterGradeEquivalent,
    -- Use window functions for ranking
    ROW_NUMBER() OVER (PARTITION BY sg.DepartmentID ORDER BY sg.AverageGradePoint DESC) AS DepartmentRank,
    -- Calculate percentile within department (0 to 100)
    PERCENT_RANK() OVER (PARTITION BY sg.DepartmentID ORDER BY sg.AverageGradePoint) * 100 AS PercentileInDepartment,
    -- Calculate how far from department average (as a percentage)
    (sg.AverageGradePoint - ds.DepartmentAverage) / ds.DepartmentAverage * 100 AS PercentFromAverage,
    -- Calculate quartile using NTILE
    NTILE(4) OVER (PARTITION BY sg.DepartmentID ORDER BY sg.AverageGradePoint DESC) AS Quartile,
    -- Department statistics
    ds.DepartmentAverage,
    ds.DepartmentMaxGPA
FROM 
    StudentGrades sg
    JOIN DepartmentStats ds ON sg.DepartmentID = ds.DepartmentID
WHERE
    -- Only show top 25% of students or those with GPA of 3.5 or higher
    sg.AverageGradePoint >= 3.5
ORDER BY
    sg.DepartmentName,
    sg.AverageGradePoint DESC;

-- This query demonstrates:
-- 1. Common Table Expressions (CTEs) for breaking down complex queries
-- 2. Multiple CTEs with dependencies between them
-- 3. Window functions for ranking and percentile calculations
-- 4. NTILE for quartile calculations
-- 5. Conditional expressions for grade classification
-- 6. Advanced analytics comparing individual to group metrics 