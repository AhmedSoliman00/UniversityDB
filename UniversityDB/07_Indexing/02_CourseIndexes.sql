-- Course and Class-Related Indexes
-- This script creates simple indexes to improve performance on course-related queries

USE [University Management System];
GO

-- Index on Courses table for fast lookup by CourseCode
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Courses_CourseCode' AND object_id = OBJECT_ID('Courses'))
BEGIN
    CREATE NONCLUSTERED INDEX IX_Courses_CourseCode
    ON Courses(CourseCode);
    
    PRINT 'Created index IX_Courses_CourseCode on Courses table';
END
ELSE
BEGIN
    PRINT 'Index IX_Courses_CourseCode already exists on Courses table';
END;
GO

-- Index on Classes table for lookup by Course
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Classes_CourseID' AND object_id = OBJECT_ID('Classes'))
BEGIN
    CREATE NONCLUSTERED INDEX IX_Classes_CourseID
    ON Classes(CourseID)
    INCLUDE (Semester, Year);
    
    PRINT 'Created index IX_Classes_CourseID on Classes table';
END
ELSE
BEGIN
    PRINT 'Index IX_Classes_CourseID already exists on Classes table';
END;
GO

PRINT 'Course-related indexes have been created successfully.';
GO 