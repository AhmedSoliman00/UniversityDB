-- Procedure: UpdateCourseCredits
-- Updates the number of credits for a given course
GO
CREATE OR ALTER PROCEDURE dbo.UpdateCourseCredits
    @CourseID INT,
    @NewCredits INT
AS
BEGIN
    UPDATE Courses
    SET Credits = @NewCredits
    WHERE CourseID = @CourseID;
END
GO 
-- Execute the procedure
EXEC dbo.UpdateCourseCredits
    @CourseID = 1,
    @NewCredits = 4;
GO 

