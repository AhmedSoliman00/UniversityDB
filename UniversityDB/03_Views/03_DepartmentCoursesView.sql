-- DepartmentCoursesView
-- This view shows all courses offered by each department
GO
CREATE OR ALTER VIEW dbo.DepartmentCoursesView
AS
SELECT 

    d.DepartmentID, d.DepartmentName, 
    c.CourseID, c.CourseCode, c.Title, c.Credits

FROM 
    Departments d

    LEFT JOIN Courses c ON d.DepartmentID = c.DepartmentID;
GO
-- Usage example:
 SELECT * FROM dbo.DepartmentCoursesView WHERE DepartmentID = 1; 