-- Student-Related Indexes
-- This script creates simple indexes to improve performance on student-related queries

USE [University Management System];
GO

-- Index on Students table for fast lookup by Email
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Students_Email' AND object_id = OBJECT_ID('Students'))
BEGIN
    CREATE NONCLUSTERED INDEX IX_Students_Email
    ON Students(Email);
    
    PRINT 'Created index IX_Students_Email on Students table';
END
ELSE
BEGIN
    PRINT 'Index IX_Students_Email already exists on Students table';
END;
GO

-- Index on Enrollments for fast lookup of classes a student is enrolled in
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Enrollments_StudentID' AND object_id = OBJECT_ID('Enrollments'))
BEGIN
    CREATE NONCLUSTERED INDEX IX_Enrollments_StudentID
    ON Enrollments(StudentID)
    INCLUDE (ClassID, IsActive);
    
    PRINT 'Created index IX_Enrollments_StudentID on Enrollments table';
END
ELSE
BEGIN
    PRINT 'Index IX_Enrollments_StudentID already exists on Enrollments table';
END;
GO

PRINT 'Student-related indexes have been created successfully.';
GO 