-- StudentProgressView
-- This view shows student progress including courses taken, grades, and credits earned

CREATE OR ALTER VIEW dbo.StudentProgressView
AS
SELECT 
    -- Student information
    s.StudentID, 
    s.FirstName + ' ' + s.LastName AS FullName,
    -- Course information
    c.CourseID,
    c.CourseCode, 
    c.Title AS CourseTitle,
    c.Credits,
    -- Class information
    cl.ClassID,
    cl.Semester,
    cl.Year,
    -- Grade information (may be NULL if not yet graded)
    g.GradeID,
    g.GradeLetter,
    g.GradePoint
FROM 
    -- 1. Start with Students table (base entity)
    Students s
    -- 2. Join to Enrollments (connects students to classes they're taking)
    INNER JOIN Enrollments e ON s.StudentID = e.StudentID
    -- 3. Join to Classes (gets specific class section details)
    INNER JOIN Classes cl ON e.ClassID = cl.ClassID
    -- 4. Join to Courses (gets course information for each class)
    INNER JOIN Courses c ON cl.CourseID = c.CourseID
    -- 5. LEFT JOIN to Grades (some enrollments may not have grades yet)
    LEFT JOIN Grades g ON e.GradeID = g.GradeID;
GO

-- Comments on join order importance:
-- 1. We start with Students as our primary entity
-- 2. The join order follows natural relationships in the schema
-- 3. Each join builds on previously joined tables
-- 4. Using LEFT JOIN for Grades ensures we see all enrollments, even without grades
-- 5. This structure allows filtering at various levels (student, course, class, etc.)

-- Usage example:
 SELECT * FROM dbo.StudentProgressView WHERE StudentID = 3 
  order by GradeLetter asc;

-- To use with ordering:
-- SELECT * FROM dbo.StudentProgressView ORDER BY GradeLetter DESC; 