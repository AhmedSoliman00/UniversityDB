-- Procedure: DeleteEnrollment
-- Deletes an enrollment record by EnrollmentID
GO
CREATE OR ALTER PROCEDURE dbo.DeleteEnrollment
    @EnrollmentID INT
AS
BEGIN
    DELETE FROM Enrollments
    WHERE EnrollmentID = @EnrollmentID;
END
GO 