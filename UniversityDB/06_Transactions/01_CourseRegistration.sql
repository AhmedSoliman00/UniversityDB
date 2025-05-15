-- Course Registration Transaction
-- Handles student course registration with basic validation

USE [University Management System];
GO

CREATE OR ALTER PROCEDURE RegisterStudentForCourse
    @StudentID INT,
    @CourseCode NVARCHAR(20),
    @Semester NVARCHAR(20),
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @CourseID INT;
    DECLARE @ClassID INT;
    DECLARE @MaxEnrollment INT;
    DECLARE @CurrentEnrollment INT;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Get course ID from course code
        SELECT @CourseID = CourseID
        FROM Courses
        WHERE CourseCode = @CourseCode;
        
        IF @CourseID IS NULL
        BEGIN
            ROLLBACK;
            RAISERROR('Course not found with the provided code.', 16, 1);
            RETURN;
        END;
        
        -- Get class ID for the course in the specified semester and year
        SELECT @ClassID = ClassID, @MaxEnrollment = MaxEnrollment, @CurrentEnrollment = CurrentEnrollment
        FROM Classes
        WHERE CourseID = @CourseID AND Semester = @Semester AND Year = @Year;
        
        IF @ClassID IS NULL
        BEGIN
            ROLLBACK;
            RAISERROR('No class found for this course in the specified semester and year.', 16, 1);
            RETURN;
        END;
        
        -- Check if class is full
        IF @CurrentEnrollment >= @MaxEnrollment
        BEGIN
            ROLLBACK;
            RAISERROR('This class is already at full capacity.', 16, 1);
            RETURN;
        END;
        
        -- Check if student exists
        IF NOT EXISTS (SELECT 1 FROM Students WHERE StudentID = @StudentID)
        BEGIN
            ROLLBACK;
            RAISERROR('Student not found with the provided ID.', 16, 1);
            RETURN;
        END;
        
        -- Check if student is already enrolled
        IF EXISTS (SELECT 1 FROM Enrollments WHERE StudentID = @StudentID AND ClassID = @ClassID AND IsActive = 1)
        BEGIN
            ROLLBACK;
            RAISERROR('Student is already enrolled in this class.', 16, 1);
            RETURN;
        END;
        
        -- Register the student
        INSERT INTO Enrollments (StudentID, ClassID, EnrollmentDate, IsActive)
        VALUES (@StudentID, @ClassID, GETDATE(), 1);
        
        -- Update current enrollment count
        UPDATE Classes
        SET CurrentEnrollment = CurrentEnrollment + 1
        WHERE ClassID = @ClassID;
        
        -- Transaction completed successfully
        COMMIT;
        
        PRINT 'Student successfully registered for the course.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;
            
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO

PRINT 'Course Registration Transaction procedure created successfully.';
GO 