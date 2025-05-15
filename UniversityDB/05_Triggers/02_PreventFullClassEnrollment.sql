-- Prevent Full Class Enrollment Trigger
-- This trigger prevents students from enrolling in classes that have reached maximum capacity

USE [University Management System];
GO

-- Create or alter the trigger
CREATE OR ALTER TRIGGER trg_PreventFullClassEnrollment
ON Enrollments
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Create a table to hold the valid enrollments
    DECLARE @ValidEnrollments TABLE (
        StudentID INT,
        ClassID INT,
        EnrollmentDate DATETIME,
        GradeID INT,
        IsActive BIT
    );
    
    -- Insert only valid enrollments (classes that are not full)
    INSERT INTO @ValidEnrollments
    SELECT 
        i.StudentID,
        i.ClassID,
        i.EnrollmentDate,
        i.GradeID,
        i.IsActive
    FROM 
        inserted i
    INNER JOIN 
        Classes c ON i.ClassID = c.ClassID
    WHERE
        c.CurrentEnrollment < c.MaxEnrollment;
    
    -- For invalid enrollments (classes that are full), raise an error
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE NOT EXISTS (
            SELECT 1 FROM @ValidEnrollments v
            WHERE v.StudentID = i.StudentID AND v.ClassID = i.ClassID
        )
    )
    BEGIN
        DECLARE @ErrorMsg NVARCHAR(200);
        SET @ErrorMsg = 'Cannot enroll student(s) in class(es) that have reached maximum capacity.';
        
        RAISERROR(@ErrorMsg, 16, 1);
        RETURN;
    END
    
    -- Insert the valid enrollments
    INSERT INTO Enrollments (
        StudentID,
        ClassID,
        EnrollmentDate,
        GradeID,
        IsActive
    )
    SELECT
        StudentID,
        ClassID,
        EnrollmentDate,
        GradeID,
        IsActive
    FROM
        @ValidEnrollments;
    
    -- Update the CurrentEnrollment count for each affected class
    UPDATE c
    SET c.CurrentEnrollment = c.CurrentEnrollment + 1
    FROM Classes c
    INNER JOIN @ValidEnrollments v ON c.ClassID = v.ClassID;
    
    PRINT 'Enrollment(s) processed successfully.';
END;
GO

PRINT 'Prevent Full Class Enrollment trigger created successfully.';
GO 