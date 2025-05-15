-- Student Major Transfer Transaction
-- Handles student transfers between majors with basic validation

USE [University Management System];
GO

CREATE OR ALTER PROCEDURE TransferStudentMajor
    @StudentID INT,
    @NewMajorName NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @NewMajorID INT;
    DECLARE @OldMajorID INT;
    DECLARE @OldMajorName NVARCHAR(100);
    DECLARE @StudentName NVARCHAR(101);
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Check if student exists and get current major
        SELECT 
            @OldMajorID = s.MajorID,
            @StudentName = s.FirstName + ' ' + s.LastName
        FROM Students s
        WHERE s.StudentID = @StudentID;
        
        IF @StudentName IS NULL
        BEGIN
            ROLLBACK;
            RAISERROR('Student not found with the provided ID.', 16, 1);
            RETURN;
        END;
        
        -- Get old major name if exists
        IF @OldMajorID IS NOT NULL
        BEGIN
            SELECT @OldMajorName = MajorName
            FROM Majors
            WHERE MajorID = @OldMajorID;
        END;
        
        -- Get new major ID
        SELECT @NewMajorID = MajorID
        FROM Majors
        WHERE MajorName = @NewMajorName;
        
        IF @NewMajorID IS NULL
        BEGIN
            ROLLBACK;
            RAISERROR('Major not found with the provided name.', 16, 1);
            RETURN;
        END;
        
        -- Check if student is already in this major
        IF @OldMajorID = @NewMajorID
        BEGIN
            ROLLBACK;
            RAISERROR('Student is already in this major.', 16, 1);
            RETURN;
        END;
        
        -- Record in student history
        INSERT INTO StudentHistory (
            StudentID,
            FieldChanged,
            OldValue,
            NewValue,
            ChangedBy,
            ChangedDate
        )
        VALUES (
            @StudentID,
            'MajorID',
            CAST(@OldMajorID AS NVARCHAR(50)),
            CAST(@NewMajorID AS NVARCHAR(50)),
            SYSTEM_USER,
            GETDATE()
        );
        
        -- Update the student's major
        UPDATE Students
        SET 
            MajorID = @NewMajorID,
            ModifiedDate = GETDATE()
        WHERE StudentID = @StudentID;
        
        -- Transaction completed successfully
        COMMIT;
        
        PRINT 'Student ' + @StudentName + ' successfully transferred from ' + 
              ISNULL(@OldMajorName, 'no major') + ' to ' + @NewMajorName + '.';
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

PRINT 'Student Major Transfer Transaction procedure created successfully.';
GO 