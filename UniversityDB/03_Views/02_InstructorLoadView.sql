-- InstructorLoadView
-- This view shows instructor teaching load including courses, class count, and student count

GO
CREATE OR ALTER VIEW dbo.InstructorLoadView
AS
SELECT 
    -- Instructor information
    i.InstructorID,
    i.FirstName + ' ' + i.LastName AS FullName,
    -- Class and course counts
    COUNT(DISTINCT cl.ClassID) AS NumberOfClasses,
    COUNT(DISTINCT c.CourseID) AS NumberOfCourses,
    -- Student counts
    COUNT(e.EnrollmentID) AS TotalEnrollments,
    COUNT(DISTINCT e.StudentID) AS UniqueStudents,
    -- Current semester details - Using STUFF with FOR XML PATH instead of STRING_AGG
    -- Workload metrics  
    SUM(c.Credits) AS TotalCredits
FROM 
    Instructors i
    LEFT JOIN Classes cl ON i.InstructorID = cl.InstructorID
    LEFT JOIN Courses c ON cl.CourseID = c.CourseID
    LEFT JOIN Enrollments e ON cl.ClassID = e.ClassID
GROUP BY
    i.InstructorID,
    i.FirstName,
    i.LastName;
GO

-- Usage example:
 SELECT * FROM dbo.InstructorLoadView WHERE InstructorID = 1;