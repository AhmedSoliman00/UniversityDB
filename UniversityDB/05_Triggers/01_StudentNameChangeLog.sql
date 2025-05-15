-- Student Name Change Log Trigger
-- This trigger logs any changes to student names in the StudentHistory audit table

USE [University Management System];
GO

-- Create or alter the trigger
CREATE OR ALTER TRIGGER trg_StudentNameChange
ON Students
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON; -- Prevent extra output
    
    -- Only execute if FirstName or LastName was changed
    IF UPDATE(FirstName) OR UPDATE(LastName)
    BEGIN
        -- Log FirstName changes
        INSERT INTO StudentHistory (
            StudentID,
            FieldChanged,
            OldValue,
            NewValue,
            ChangedBy,
            ChangedDate
        )
        SELECT
            i.StudentID,
            'FirstName',
            d.FirstName,
            i.FirstName,
            SYSTEM_USER,
            GETDATE()
        FROM 
            inserted i
        INNER JOIN 
            deleted d ON i.StudentID = d.StudentID
        WHERE
            i.FirstName <> d.FirstName;
            
        -- Log LastName changes
        INSERT INTO StudentHistory (
            StudentID,
            FieldChanged,
            OldValue,
            NewValue,
            ChangedBy,
            ChangedDate
        )
        SELECT
            i.StudentID,
            'LastName',
            d.LastName,
            i.LastName,
            SYSTEM_USER,
            GETDATE()
        FROM 
            inserted i
        INNER JOIN 
            deleted d ON i.StudentID = d.StudentID
        WHERE
            i.LastName <> d.LastName;
            
        PRINT 'Student name change logged to StudentHistory.';
    END
END;
GO

PRINT 'Student Name Change Log trigger created successfully.';
GO 
-- Test the trigger
UPDATE Students
SET FirstName = 'ahmed'
WHERE StudentID = 1;

select * from StudentHistory;


