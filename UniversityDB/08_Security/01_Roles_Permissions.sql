-- Database Roles and Permissions
-- This script creates database roles and assigns permissions

USE [University Management System];
GO

PRINT '---------------------------------------------------------------------';
PRINT 'CREATING DATABASE ROLES AND ASSIGNING PERMISSIONS';
PRINT '---------------------------------------------------------------------';
PRINT '';

-- Drop existing roles if they exist to avoid errors
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'StudentRole' AND type = 'R')
    DROP ROLE StudentRole;

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'InstructorRole' AND type = 'R')
    DROP ROLE InstructorRole;

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'AdminRole' AND type = 'R')
    DROP ROLE AdminRole;

-- Create roles
PRINT 'Creating database roles...';
CREATE ROLE StudentRole;
CREATE ROLE InstructorRole;
CREATE ROLE AdminRole;
PRINT 'Roles created successfully!';
PRINT '';

-- Grant permissions for StudentRole
PRINT 'Assigning permissions to StudentRole...';
-- Students can only read (SELECT) from specific tables
GRANT SELECT ON Students TO StudentRole;
GRANT SELECT ON Courses TO StudentRole;
GRANT SELECT ON Classes TO StudentRole;
GRANT SELECT ON Enrollments TO StudentRole;
GRANT SELECT ON Grades TO StudentRole;
GRANT SELECT ON Majors TO StudentRole;
GRANT SELECT ON Instructors TO StudentRole;
GRANT SELECT ON Departments TO StudentRole;

-- Students can update their own enrollment status but not add/delete
GRANT UPDATE ON Enrollments TO StudentRole;

-- Explicitly deny other permissions
DENY INSERT, DELETE ON Enrollments TO StudentRole;
DENY INSERT, UPDATE, DELETE ON Students TO StudentRole;
DENY INSERT, UPDATE, DELETE ON Classes TO StudentRole;
PRINT 'StudentRole permissions assigned!';
PRINT '';

-- Grant permissions for InstructorRole
PRINT 'Assigning permissions to InstructorRole...';
-- Instructors can read all tables
GRANT SELECT ON Students TO InstructorRole;
GRANT SELECT ON Courses TO InstructorRole; 
GRANT SELECT ON Classes TO InstructorRole;
GRANT SELECT ON Enrollments TO InstructorRole;
GRANT SELECT ON Grades TO InstructorRole;
GRANT SELECT ON Majors TO InstructorRole;
GRANT SELECT ON Instructors TO InstructorRole;
GRANT SELECT ON Departments TO InstructorRole;

-- Instructors can update grades and enrollment information
GRANT UPDATE ON Enrollments TO InstructorRole;
GRANT INSERT, UPDATE ON Grades TO InstructorRole;

-- Instructors can manage their classes
GRANT UPDATE ON Classes TO InstructorRole;

-- Deny critical permissions
DENY INSERT, DELETE ON Students TO InstructorRole;
DENY INSERT, DELETE ON Courses TO InstructorRole;
DENY DELETE ON Classes TO InstructorRole;
PRINT 'InstructorRole permissions assigned!';
PRINT '';

-- Grant permissions for AdminRole
PRINT 'Assigning permissions to AdminRole...';
-- Admins have full control over all tables
GRANT SELECT, INSERT, UPDATE, DELETE ON Students TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON Courses TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON Classes TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON Enrollments TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON Grades TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON Majors TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON Instructors TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON Departments TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON Payments TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON StudentHistory TO AdminRole;
PRINT 'AdminRole permissions assigned!';
PRINT '';

-- Create test users for demonstration purposes
PRINT 'Creating test users...';

-- Drop users if they exist
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'TestStudent' AND type = 'S')
    DROP USER TestStudent;
    
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'TestInstructor' AND type = 'S')
    DROP USER TestInstructor;
    
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'TestAdmin' AND type = 'S')
    DROP USER TestAdmin;

-- Check if logins exist at server level, create if they don't
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'TestStudent')
    CREATE LOGIN TestStudent WITH PASSWORD = 'Student123!';
    
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'TestInstructor')
    CREATE LOGIN TestInstructor WITH PASSWORD = 'Instructor123!';
    
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'TestAdmin')
    CREATE LOGIN TestAdmin WITH PASSWORD = 'Admin123!';

-- Create database users and assign to roles
CREATE USER TestStudent FOR LOGIN TestStudent;
CREATE USER TestInstructor FOR LOGIN TestInstructor;
CREATE USER TestAdmin FOR LOGIN TestAdmin;

-- Add users to roles
ALTER ROLE StudentRole ADD MEMBER TestStudent;
ALTER ROLE InstructorRole ADD MEMBER TestInstructor;
ALTER ROLE AdminRole ADD MEMBER TestAdmin;

PRINT 'Test users created and assigned to roles successfully!';
PRINT '';

PRINT '---------------------------------------------------------------------';
PRINT 'SECURITY SETUP COMPLETED';
PRINT '---------------------------------------------------------------------';
PRINT 'Created roles: StudentRole, InstructorRole, AdminRole';
PRINT 'Created test users: TestStudent, TestInstructor, TestAdmin';
PRINT '';
PRINT 'Use the 01_Test_Roles.sql script to verify role permissions.';
GO 