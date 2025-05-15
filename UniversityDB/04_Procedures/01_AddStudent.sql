-- Procedure: AddStudent
-- Adds a new student to the Students table
GO
CREATE OR ALTER PROCEDURE dbo.AddStudent
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(100),
    @DateOfBirth DATE = NULL,
    @MajorID INT = NULL
AS
BEGIN
    INSERT INTO Students (FirstName, LastName, Email, DateOfBirth, MajorID)
    VALUES (@FirstName, @LastName, @Email, @DateOfBirth, @MajorID);
END
GO 
-- Execute the procedure
EXEC dbo.AddStudent 
    @FirstName = 'Ahmed', 
    @LastName = 'Soliman', 
    @Email = 'ahmed.soliman@university.edu', 
    @DateOfBirth = '1990-01-01', 
    @MajorID = 1;