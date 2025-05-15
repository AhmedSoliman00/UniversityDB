-- Function: GetCourseCredits
-- Returns the number of credits for a given CourseID
GO
CREATE OR ALTER FUNCTION dbo.GetCourseCredits(@CourseID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Credits INT;
    SELECT @Credits = Credits
    FROM Courses
    WHERE CourseID = @CourseID;
    RETURN @Credits;
END
GO 
-- Example usage
SELECT dbo.GetCourseCredits(1) AS Credits;
SELECT dbo.GetCourseCredits(2) AS Credits;
SELECT dbo.GetCourseCredits(3) AS Credits;
GO 