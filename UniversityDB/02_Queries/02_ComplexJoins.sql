-- Advanced Query Example: Complex Joins
-- This query demonstrates the use of multiple types of joins and aggregations

-- Find the instructors with the highest average student grades
-- along with their department information and teaching history

SELECT 
    d.DepartmentName,
    i.FirstName + ' ' + i.LastName AS InstructorName,
    COUNT(DISTINCT cl.ClassID) AS TotalClassesTaught,
    COUNT(DISTINCT e.StudentID) AS TotalStudents,
    AVG(g.GradePoint) AS AverageStudentGrade,
    MIN(g.GradePoint) AS LowestGrade,
    MAX(g.GradePoint) AS HighestGrade,
    AVG(CASE 
            WHEN g.GradeLetter = 'A' THEN 1.0 
            ELSE 0.0 
        END) * 100 AS PercentageOfAGrades
FROM 
    Instructors i
    -- Start with department to include all departments
    INNER JOIN Departments d ON i.DepartmentID = d.DepartmentID
    -- Left join to classes to include instructors who haven't taught any classes
    LEFT JOIN Classes cl ON i.InstructorID = cl.InstructorID
    -- Left join to courses to get course information
    LEFT JOIN Courses c ON cl.CourseID = c.CourseID
    -- Left join to enrollments to get student enrollment information
    LEFT JOIN Enrollments e ON cl.ClassID = e.ClassID
    -- Left join to grades to get grade information (may be NULL if not yet graded)
    LEFT JOIN Grades g ON e.GradeID = g.GradeID
GROUP BY
    d.DepartmentName,
    i.InstructorID,
    i.FirstName,
    i.LastName
HAVING 
    -- Only include instructors who have taught at least one class with grades
    COUNT(g.GradeID) > 0
ORDER BY 
    AVG(g.GradePoint) DESC,
    COUNT(DISTINCT e.StudentID) DESC;

-- This query demonstrates:
-- 1. Complex multi-table joins (INNER and LEFT joins)
-- 2. Multiple aggregation functions (COUNT, AVG, MIN, MAX)
-- 3. Conditional aggregation using CASE expressions
-- 4. HAVING clause for filtering after aggregation
-- 5. Multi-level sorting 