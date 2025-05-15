-- University Management System - Tables Creation
-- Created: May 12, 2025

USE [University Management System];
GO

-- Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    DateOfBirth DATE,
    Gender NVARCHAR(10),
    Address NVARCHAR(200),
    Phone NVARCHAR(20),
    EnrollmentDate DATE DEFAULT GETDATE(),
    MajorID INT,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO

-- Instructors Table
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(20),
    HireDate DATE DEFAULT GETDATE(),
    Salary DECIMAL(10, 2),
    DepartmentID INT,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(100) NOT NULL,
    Location NVARCHAR(100),
    Budget DECIMAL(12, 2),
    ChairID INT, -- Reference to an Instructor
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO -- This statement marks the end of a batch of SQL commands. 
     -- It ensures the Departments table is fully created before moving on to the next statement.

-- Courses Table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY IDENTITY(1,1),
    CourseCode NVARCHAR(20) UNIQUE NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    Credits INT NOT NULL,
    DepartmentID INT,
    PrerequisiteCourseID INT, -- Self-reference
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO

-- Majors Table
CREATE TABLE Majors (
    MajorID INT PRIMARY KEY IDENTITY(1,1),
    MajorName NVARCHAR(100) NOT NULL,
    DepartmentID INT,
    RequiredCredits INT,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO

-- Classes (Course Instances) Table
CREATE TABLE Classes (
    ClassID INT PRIMARY KEY IDENTITY(1,1),
    CourseID INT NOT NULL,
    InstructorID INT,
    Semester NVARCHAR(20) NOT NULL,
    Year INT NOT NULL,
    StartDate DATE,
    EndDate DATE,
    Room NVARCHAR(50),
    BuildingName NVARCHAR(100),
    DaysOfWeek NVARCHAR(20), -- e.g., "MWF" for Monday, Wednesday, Friday
    StartTime TIME,
    EndTime TIME,
    MaxEnrollment INT DEFAULT 30,
    CurrentEnrollment INT DEFAULT 0,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO

-- Enrollments Table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT NOT NULL,
    ClassID INT NOT NULL,
    EnrollmentDate DATETIME DEFAULT GETDATE(),
    GradeID INT,
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO

-- Grades Table
CREATE TABLE Grades (
    GradeID INT PRIMARY KEY IDENTITY(1,1),
    GradeLetter NVARCHAR(2) NOT NULL, -- A, A-, B+, B, etc.
    GradePoint DECIMAL(3, 2) NOT NULL, -- 4.0, 3.7, 3.3, 3.0, etc.
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO

-- StudentHistory (Audit) Table
CREATE TABLE StudentHistory (
    HistoryID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT NOT NULL,
    FieldChanged NVARCHAR(50) NOT NULL,
    OldValue NVARCHAR(MAX),
    NewValue NVARCHAR(MAX),
    ChangedBy NVARCHAR(100),
    ChangedDate DATETIME DEFAULT GETDATE()
);
GO

-- Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    PaymentMethod NVARCHAR(50), -- Credit Card, Cash, etc.
    PaymentStatus NVARCHAR(20) DEFAULT 'Completed', -- Pending, Completed, Failed
    ReferenceNumber NVARCHAR(50),
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO

PRINT 'All tables created successfully.';
GO 