-- Test Database Roles and Permissions
-- This script tests the permissions of each role created in 01_Roles_Permissions.sql

USE [University Management System];
GO

PRINT '---------------------------------------------------------------------';
PRINT 'TESTING DATABASE ROLES AND PERMISSIONS';
PRINT '---------------------------------------------------------------------';
PRINT '';
GO

-- Function to print test results in a consistent format
CREATE OR ALTER FUNCTION dbo.TestResult(@TestName NVARCHAR(100), @Expected NVARCHAR(50), @Actual NVARCHAR(50))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Result NVARCHAR(MAX);
    DECLARE @Status NVARCHAR(10);
    
    IF @Expected = @Actual
        SET @Status = 'PASS';
    ELSE
        SET @Status = 'FAIL';
        
    SET @Result = @TestName + ' - Expected: ' + @Expected + ', Actual: ' + @Actual + ' - ' + @Status;
    
    RETURN @Result;
END;
GO

-- Test StudentRole permissions
PRINT 'TESTING STUDENTROLE PERMISSIONS';
PRINT '------------------------------';

-- 1. Test SELECT permission on Students table (should succeed)
BEGIN TRY
    EXECUTE AS USER = 'TestStudent';
    SELECT TOP 1 * FROM Students;
    REVERT;
    PRINT dbo.TestResult('Student SELECT on Students', 'Success', 'Success');
END TRY
BEGIN CATCH
    REVERT;
    PRINT dbo.TestResult('Student SELECT on Students', 'Success', 'Failed - ' + ERROR_MESSAGE());
END CATCH;

-- 2. Test INSERT permission on Students table (should fail)
BEGIN TRY
    EXECUTE AS USER = 'TestStudent';
    INSERT INTO Students (FirstName, LastName, Email) 
    VALUES ('Test', 'Student', 'test.student@example.com');
    REVERT;
    PRINT dbo.TestResult('Student INSERT on Students', 'Fail', 'Success - This should not happen');
END TRY
BEGIN CATCH
    REVERT;
    PRINT dbo.TestResult('Student INSERT on Students', 'Fail', 'Fail - Permission denied as expected');
END CATCH;

-- 3. Test UPDATE permission on Enrollments table (should succeed)
BEGIN TRY
    EXECUTE AS USER = 'TestStudent';
    -- This is a test update that won't actually change data
    UPDATE TOP(0) Enrollments SET IsActive = IsActive;
    REVERT;
    PRINT dbo.TestResult('Student UPDATE on Enrollments', 'Success', 'Success');
END TRY
BEGIN CATCH
    REVERT;
    PRINT dbo.TestResult('Student UPDATE on Enrollments', 'Success', 'Failed - ' + ERROR_MESSAGE());
END CATCH;

PRINT '';

-- Test InstructorRole permissions
PRINT 'TESTING INSTRUCTORROLE PERMISSIONS';
PRINT '--------------------------------';

-- 1. Test SELECT permission on Students table (should succeed)
BEGIN TRY
    EXECUTE AS USER = 'TestInstructor';
    SELECT TOP 1 * FROM Students;
    REVERT;
    PRINT dbo.TestResult('Instructor SELECT on Students', 'Success', 'Success');
END TRY
BEGIN CATCH
    REVERT;
    PRINT dbo.TestResult('Instructor SELECT on Students', 'Success', 'Failed - ' + ERROR_MESSAGE());
END CATCH;

-- 2. Test INSERT permission on Grades table (should succeed)
BEGIN TRY
    EXECUTE AS USER = 'TestInstructor';
    -- This is a test insert that will roll back
    BEGIN TRANSACTION;
    INSERT INTO Grades (GradeLetter, GradePoint) 
    VALUES ('X', 0.0);
    ROLLBACK;
    REVERT;
    PRINT dbo.TestResult('Instructor INSERT on Grades', 'Success', 'Success');
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK;
    REVERT;
    PRINT dbo.TestResult('Instructor INSERT on Grades', 'Success', 'Failed - ' + ERROR_MESSAGE());
END CATCH;

-- 3. Test DELETE permission on Courses table (should fail)
BEGIN TRY
    EXECUTE AS USER = 'TestInstructor';
    DELETE TOP(0) FROM Courses;
    REVERT;
    PRINT dbo.TestResult('Instructor DELETE on Courses', 'Fail', 'Success - This should not happen');
END TRY
BEGIN CATCH
    REVERT;
    PRINT dbo.TestResult('Instructor DELETE on Courses', 'Fail', 'Fail - Permission denied as expected');
END CATCH;

PRINT '';

-- Test AdminRole permissions
PRINT 'TESTING ADMINROLE PERMISSIONS';
PRINT '----------------------------';

-- 1. Test SELECT permission on all tables (should succeed)
BEGIN TRY
    EXECUTE AS USER = 'TestAdmin';
    SELECT TOP 1 * FROM Students;
    SELECT TOP 1 * FROM Courses;
    SELECT TOP 1 * FROM Enrollments;
    REVERT;
    PRINT dbo.TestResult('Admin SELECT on all tables', 'Success', 'Success');
END TRY
BEGIN CATCH
    REVERT;
    PRINT dbo.TestResult('Admin SELECT on all tables', 'Success', 'Failed - ' + ERROR_MESSAGE());
END CATCH;

-- 2. Test INSERT permission on Courses table (should succeed)
BEGIN TRY
    EXECUTE AS USER = 'TestAdmin';
    -- This is a test insert that will roll back
    BEGIN TRANSACTION;
    INSERT INTO Courses (CourseCode, Title, Credits, DepartmentID) 
    VALUES ('TEST101', 'Test Course', 3, 1);
    ROLLBACK;
    REVERT;
    PRINT dbo.TestResult('Admin INSERT on Courses', 'Success', 'Success');
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK;
    REVERT;
    PRINT dbo.TestResult('Admin INSERT on Courses', 'Success', 'Failed - ' + ERROR_MESSAGE());
END CATCH;

-- 3. Test DELETE permission on Students table (should succeed)
BEGIN TRY
    EXECUTE AS USER = 'TestAdmin';
    -- This is a test delete that won't actually delete data
    BEGIN TRANSACTION;
    DELETE TOP(0) FROM Students;
    ROLLBACK;
    REVERT;
    PRINT dbo.TestResult('Admin DELETE on Students', 'Success', 'Success');
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK;
    REVERT;
    PRINT dbo.TestResult('Admin DELETE on Students', 'Success', 'Failed - ' + ERROR_MESSAGE());
END CATCH;

PRINT '';
PRINT '---------------------------------------------------------------------';
PRINT 'ROLE TESTING COMPLETED';
PRINT '---------------------------------------------------------------------';
PRINT '';
PRINT 'Note: Some tests verify that permissions are properly DENIED.';
PRINT 'In these cases, a "Fail" result is actually expected and correct.';

-- Clean up the test function
DROP FUNCTION IF EXISTS dbo.TestResult;
GO 