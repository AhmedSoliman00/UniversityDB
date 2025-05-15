-- Department and Instructor-Related Indexes
-- This script creates simple indexes to improve performance on department and instructor-related queries

USE [University Management System];
GO

-- Index on Departments table for name lookups
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Departments_DepartmentName' AND object_id = OBJECT_ID('Departments'))
BEGIN
    CREATE NONCLUSTERED INDEX IX_Departments_DepartmentName
    ON Departments(DepartmentName);
    
    PRINT 'Created index IX_Departments_DepartmentName on Departments table';
END
ELSE
BEGIN
    PRINT 'Index IX_Departments_DepartmentName already exists on Departments table';
END;
GO

-- Index on Instructors table for department lookup
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Instructors_DepartmentID' AND object_id = OBJECT_ID('Instructors'))
BEGIN
    CREATE NONCLUSTERED INDEX IX_Instructors_DepartmentID
    ON Instructors(DepartmentID)
    INCLUDE (FirstName, LastName);
    
    PRINT 'Created index IX_Instructors_DepartmentID on Instructors table';
END
ELSE
BEGIN
    PRINT 'Index IX_Instructors_DepartmentID already exists on Instructors table';
END;
GO

PRINT 'Department and instructor-related indexes have been created successfully.';
GO 