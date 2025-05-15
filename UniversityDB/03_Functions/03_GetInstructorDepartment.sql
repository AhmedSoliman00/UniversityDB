-- Function: GetInstructorDepartment
-- Returns the department name for a given InstructorID
GO
CREATE OR ALTER FUNCTION dbo.GetInstructorDepartment(@InstructorID INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @DepartmentName NVARCHAR(100);
    SELECT @DepartmentName = d.DepartmentName
    FROM Instructors i
    JOIN Departments d ON i.DepartmentID = d.DepartmentID
    WHERE i.InstructorID = @InstructorID;
    RETURN @DepartmentName;
END
GO 
-- Example usage
SELECT dbo.GetInstructorDepartment(1) AS DepartmentName;
SELECT dbo.GetInstructorDepartment(2) AS DepartmentName;
SELECT dbo.GetInstructorDepartment(3) AS DepartmentName;
GO 