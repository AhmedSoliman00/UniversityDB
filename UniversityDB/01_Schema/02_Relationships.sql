-- University Management System - Table Relationships
-- Created: May 12, 2025

USE [University Management System];
GO

-- Adding Foreign Key Constraints

-- Students Table - Foreign Keys
ALTER TABLE Students
ADD CONSTRAINT FK_Students_Majors
FOREIGN KEY (MajorID) REFERENCES Majors(MajorID);
GO

-- Instructors Table - Foreign Keys
ALTER TABLE Instructors
ADD CONSTRAINT FK_Instructors_Departments
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);
GO

-- Departments Table - Foreign Keys
ALTER TABLE Departments
ADD CONSTRAINT FK_Departments_Instructors
FOREIGN KEY (ChairID) REFERENCES Instructors(InstructorID);
GO

-- Courses Table - Foreign Keys
ALTER TABLE Courses
ADD CONSTRAINT FK_Courses_Departments
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

ALTER TABLE Courses
ADD CONSTRAINT FK_Courses_Prerequisites
FOREIGN KEY (PrerequisiteCourseID) REFERENCES Courses(CourseID);
GO

-- Majors Table - Foreign Keys
ALTER TABLE Majors
ADD CONSTRAINT FK_Majors_Departments
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);
GO

-- Classes Table - Foreign Keys
ALTER TABLE Classes
ADD CONSTRAINT FK_Classes_Courses
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID);

ALTER TABLE Classes
ADD CONSTRAINT FK_Classes_Instructors
FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID);
GO

-- Enrollments Table - Foreign Keys
ALTER TABLE Enrollments
ADD CONSTRAINT FK_Enrollments_Students
FOREIGN KEY (StudentID) REFERENCES Students(StudentID);

ALTER TABLE Enrollments
ADD CONSTRAINT FK_Enrollments_Classes
FOREIGN KEY (ClassID) REFERENCES Classes(ClassID);

ALTER TABLE Enrollments
ADD CONSTRAINT FK_Enrollments_Grades
FOREIGN KEY (GradeID) REFERENCES Grades(GradeID);
GO

-- StudentHistory Table - Foreign Keys
ALTER TABLE StudentHistory
ADD CONSTRAINT FK_StudentHistory_Students
FOREIGN KEY (StudentID) REFERENCES Students(StudentID);
GO

-- Payments Table - Foreign Keys
ALTER TABLE Payments
ADD CONSTRAINT FK_Payments_Students
FOREIGN KEY (StudentID) REFERENCES Students(StudentID);
GO

-- Create unique constraint to ensure a student can't enroll in the same class twice
ALTER TABLE Enrollments
ADD CONSTRAINT UQ_Enrollment_Student_Class UNIQUE (StudentID, ClassID);
GO

PRINT 'All relationships and constraints added successfully.';
GO 