-- Simple Subquery Example
-- This query demonstrates basic subquery usage in WHERE and FROM clauses

-- Find students who have above-average grades

-- First, a simple subquery in the WHERE clause
SELECT 
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS StudentName,
    AVG(g.GradePoint) AS AverageGrade
FROM 
    Students s
    JOIN Enrollments e ON s.StudentID = e.StudentID
    JOIN Grades g ON e.GradeID = g.GradeID
GROUP BY 
    s.StudentID, 
    s.FirstName,
    s.LastName
-- Subquery in WHERE: Only include students with above-average grades
HAVING 
    AVG(g.GradePoint) > (
        SELECT AVG(g2.GradePoint) 
        FROM Grades g2
        JOIN Enrollments e2 ON g2.GradeID = e2.GradeID
    )
ORDER BY 
    AVG(g.GradePoint) DESC;



