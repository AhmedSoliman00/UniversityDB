-- Update Modified Date Trigger
-- This trigger automatically updates the ModifiedDate field whenever a record is updated

USE [University Management System];
GO

-- Create or alter the trigger for Students table
CREATE OR ALTER TRIGGER trg_UpdateStudentsModifiedDate
ON Students
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE s
    SET s.ModifiedDate = GETDATE()
    FROM Students s
    INNER JOIN inserted i ON s.StudentID = i.StudentID;
END;
GO

-- Create or alter the trigger for Instructors table
CREATE OR ALTER TRIGGER trg_UpdateInstructorsModifiedDate
ON Instructors
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE i
    SET i.ModifiedDate = GETDATE()
    FROM Instructors i
    INNER JOIN inserted ins ON i.InstructorID = ins.InstructorID;
END;
GO

-- Create or alter the trigger for Departments table
CREATE OR ALTER TRIGGER trg_UpdateDepartmentsModifiedDate
ON Departments
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE d
    SET d.ModifiedDate = GETDATE()
    FROM Departments d
    INNER JOIN inserted i ON d.DepartmentID = i.DepartmentID;
END;
GO

-- Create or alter the trigger for Courses table
CREATE OR ALTER TRIGGER trg_UpdateCoursesModifiedDate
ON Courses
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE c
    SET c.ModifiedDate = GETDATE()
    FROM Courses c
    INNER JOIN inserted i ON c.CourseID = i.CourseID;
END;
GO

-- Create or alter the trigger for Majors table
CREATE OR ALTER TRIGGER trg_UpdateMajorsModifiedDate
ON Majors
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE m
    SET m.ModifiedDate = GETDATE()
    FROM Majors m
    INNER JOIN inserted i ON m.MajorID = i.MajorID;
END;
GO

-- Create or alter the trigger for Classes table
CREATE OR ALTER TRIGGER trg_UpdateClassesModifiedDate
ON Classes
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE c
    SET c.ModifiedDate = GETDATE()
    FROM Classes c
    INNER JOIN inserted i ON c.ClassID = i.ClassID;
END;
GO

-- Create or alter the trigger for Enrollments table
CREATE OR ALTER TRIGGER trg_UpdateEnrollmentsModifiedDate
ON Enrollments
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE e
    SET e.ModifiedDate = GETDATE()
    FROM Enrollments e
    INNER JOIN inserted i ON e.EnrollmentID = i.EnrollmentID;
END;
GO

PRINT 'Update Modified Date triggers created successfully.';
GO 