-- Function: GetStudentFullName
-- Returns the full name of a student given their StudentID
GO
CREATE OR ALTER FUNCTION dbo.GetStudentFullName(@StudentID INT)
RETURNS NVARCHAR(101)
AS
BEGIN
    DECLARE @FullName NVARCHAR(101);
    SELECT @FullName = FirstName + ' ' + LastName
    FROM Students
    WHERE StudentID = @StudentID;
    RETURN @FullName;
END
GO 

-- Example usage
SELECT dbo.GetStudentFullName(1) AS FullName;
SELECT dbo.GetStudentFullName(2) AS FullName;
SELECT dbo.GetStudentFullName(3) AS FullName;
GO 