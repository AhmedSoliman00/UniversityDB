USE [University Management System];
GO

-- Clear existing data if needed
DELETE FROM Payments;
DELETE FROM Enrollments;
DELETE FROM StudentHistory;
DELETE FROM Students;
DELETE FROM Classes;
DELETE FROM Courses;
DELETE FROM Majors;
DELETE FROM Instructors;
DELETE FROM Departments;
DELETE FROM Grades;
GO

-- Insert Departments
INSERT INTO Departments (DepartmentName, Location, Budget)
VALUES 
('Computer Science', 'Science Building, Floor 3', 1500000.00),
('Business Administration', 'Business Building, Floor 2', 2000000.00),
('Electrical Engineering', 'Engineering Building, Floor 1', 1750000.00),
('Mathematics', 'Science Building, Floor 2', 1000000.00),
('English', 'Liberal Arts Building, Floor 3', 950000.00),
('Psychology', 'Social Sciences Building, Floor 1', 1200000.00),
('Physics', 'Science Building, Floor 1', 1400000.00),
('Chemistry', 'Science Building, Floor 4', 1600000.00);
GO

-- Insert Instructors
INSERT INTO Instructors (FirstName, LastName, Email, Phone, HireDate, Salary, DepartmentID)
VALUES
('John', 'Smith', 'john.smith@university.edu', '555-123-4567', '2015-08-15', 95000.00, 1),
('Mary', 'Johnson', 'mary.johnson@university.edu', '555-234-5678', '2010-06-20', 105000.00, 2),
('Robert', 'Williams', 'robert.williams@university.edu', '555-345-6789', '2018-01-10', 88000.00, 3),
('Jennifer', 'Brown', 'jennifer.brown@university.edu', '555-456-7890', '2013-09-01', 92000.00, 4),
('Michael', 'Davis', 'michael.davis@university.edu', '555-567-8901', '2016-07-15', 89000.00, 5),
('Patricia', 'Miller', 'patricia.miller@university.edu', '555-678-9012', '2019-02-28', 85000.00, 6),
('James', 'Wilson', 'james.wilson@university.edu', '555-789-0123', '2014-11-15', 93000.00, 7),
('Linda', 'Moore', 'linda.moore@university.edu', '555-890-1234', '2017-05-10', 87000.00, 8),
('William', 'Taylor', 'william.taylor@university.edu', '555-901-2345', '2012-08-20', 98000.00, 1),
('Elizabeth', 'Anderson', 'elizabeth.anderson@university.edu', '555-012-3456', '2020-01-15', 82000.00, 2),
('David', 'Thomas', 'david.thomas@university.edu', '555-123-4567', '2015-04-12', 91000.00, 3),
('Barbara', 'Jackson', 'barbara.jackson@university.edu', '555-234-5678', '2011-09-30', 99000.00, 4);
GO

-- Update Department chairs
UPDATE Departments SET ChairID = 1 WHERE DepartmentID = 1;
UPDATE Departments SET ChairID = 2 WHERE DepartmentID = 2;
UPDATE Departments SET ChairID = 3 WHERE DepartmentID = 3;
UPDATE Departments SET ChairID = 4 WHERE DepartmentID = 4;
UPDATE Departments SET ChairID = 5 WHERE DepartmentID = 5;
UPDATE Departments SET ChairID = 6 WHERE DepartmentID = 6;
UPDATE Departments SET ChairID = 7 WHERE DepartmentID = 7;
UPDATE Departments SET ChairID = 8 WHERE DepartmentID = 8;
GO

-- Insert Majors
INSERT INTO Majors (MajorName, DepartmentID, RequiredCredits)
VALUES
('Computer Science', 1, 120),
('Information Technology', 1, 120),
('Cybersecurity', 1, 125),
('Business Administration', 2, 120),
('Marketing', 2, 120),
('Finance', 2, 125),
('Electrical Engineering', 3, 130),
('Electronics', 3, 128),
('Applied Mathematics', 4, 120),
('Statistics', 4, 120),
('English Literature', 5, 120),
('Creative Writing', 5, 120),
('Clinical Psychology', 6, 130),
('Cognitive Science', 6, 125),
('Physics', 7, 128),
('Theoretical Physics', 7, 130),
('Chemistry', 8, 128),
('Biochemistry', 8, 130);
GO

-- Insert Grades
INSERT INTO Grades (GradeLetter, GradePoint)
VALUES
('A+', 4.00),
('A', 4.00),
('A-', 3.70),
('B+', 3.30),
('B', 3.00),
('B-', 2.70),
('C+', 2.30),
('C', 2.00),
('C-', 1.70),
('D+', 1.30),
('D', 1.00),
('D-', 0.70),
('F', 0.00);
GO

-- Insert Courses
INSERT INTO Courses (CourseCode, Title, Description, Credits, DepartmentID)
VALUES
('CS101', 'Introduction to Programming', 'Basic concepts of programming using Python', 3, 1),
('CS201', 'Data Structures', 'Fundamental data structures and algorithms', 4, 1),
('CS301', 'Database Systems', 'Database design and SQL', 4, 1),
('BUS101', 'Introduction to Business', 'Overview of business concepts', 3, 2),
('BUS201', 'Financial Accounting', 'Principles of accounting', 4, 2),
('BUS301', 'Marketing Principles', 'Introduction to marketing concepts', 3, 2),
('EE101', 'Circuit Analysis', 'Basic electrical circuit analysis', 4, 3),
('EE201', 'Digital Logic Design', 'Fundamentals of digital systems', 4, 3),
('MATH101', 'Calculus I', 'Limits, derivatives, and integrals', 4, 4),
('MATH201', 'Linear Algebra', 'Vector spaces and linear transformations', 3, 4),
('ENG101', 'Composition', 'College writing skills', 3, 5),
('ENG201', 'American Literature', 'Survey of American literature', 3, 5),
('PSY101', 'Introduction to Psychology', 'Basic psychological concepts', 3, 6),
('PSY201', 'Developmental Psychology', 'Human development across the lifespan', 3, 6),
('PHYS101', 'Physics I', 'Mechanics and thermodynamics', 4, 7),
('PHYS201', 'Physics II', 'Electricity and magnetism', 4, 7),
('CHEM101', 'General Chemistry I', 'Atomic structure and chemical bonding', 4, 8),
('CHEM201', 'Organic Chemistry', 'Properties and reactions of organic compounds', 4, 8);
GO

-- Add prerequisites (for some courses)
UPDATE Courses SET PrerequisiteCourseID = 1 WHERE CourseCode = 'CS201';
UPDATE Courses SET PrerequisiteCourseID = 2 WHERE CourseCode = 'CS301';
UPDATE Courses SET PrerequisiteCourseID = 4 WHERE CourseCode = 'BUS201';
UPDATE Courses SET PrerequisiteCourseID = 4 WHERE CourseCode = 'BUS301';
UPDATE Courses SET PrerequisiteCourseID = 7 WHERE CourseCode = 'EE201';
UPDATE Courses SET PrerequisiteCourseID = 9 WHERE CourseCode = 'MATH201';
UPDATE Courses SET PrerequisiteCourseID = 11 WHERE CourseCode = 'ENG201';
UPDATE Courses SET PrerequisiteCourseID = 13 WHERE CourseCode = 'PSY201';
UPDATE Courses SET PrerequisiteCourseID = 15 WHERE CourseCode = 'PHYS201';
UPDATE Courses SET PrerequisiteCourseID = 17 WHERE CourseCode = 'CHEM201';
GO

-- Insert Classes (Fall 2023 semester)
INSERT INTO Classes (CourseID, InstructorID, Semester, Year, StartDate, EndDate, Room, BuildingName, DaysOfWeek, StartTime, EndTime, MaxEnrollment)
VALUES
(1, 1, 'Fall', 2023, '2023-08-28', '2023-12-15', '101', 'Science Building', 'MWF', '09:00:00', '09:50:00', 35),
(2, 9, 'Fall', 2023, '2023-08-28', '2023-12-15', '102', 'Science Building', 'TR', '10:00:00', '11:15:00', 30),
(3, 1, 'Fall', 2023, '2023-08-28', '2023-12-15', '103', 'Science Building', 'MWF', '11:00:00', '11:50:00', 25),
(4, 2, 'Fall', 2023, '2023-08-28', '2023-12-15', '201', 'Business Building', 'MWF', '09:00:00', '09:50:00', 40),
(5, 10, 'Fall', 2023, '2023-08-28', '2023-12-15', '202', 'Business Building', 'TR', '13:00:00', '14:15:00', 35),
(6, 2, 'Fall', 2023, '2023-08-28', '2023-12-15', '203', 'Business Building', 'MWF', '14:00:00', '14:50:00', 30),
(7, 3, 'Fall', 2023, '2023-08-28', '2023-12-15', '101', 'Engineering Building', 'MWF', '10:00:00', '10:50:00', 30),
(8, 11, 'Fall', 2023, '2023-08-28', '2023-12-15', '102', 'Engineering Building', 'TR', '09:00:00', '10:15:00', 25),
(9, 4, 'Fall', 2023, '2023-08-28', '2023-12-15', '201', 'Science Building', 'MWF', '13:00:00', '13:50:00', 35),
(10, 12, 'Fall', 2023, '2023-08-28', '2023-12-15', '202', 'Science Building', 'TR', '15:00:00', '16:15:00', 30);
GO

-- Insert Classes (Spring 2024 semester)
INSERT INTO Classes (CourseID, InstructorID, Semester, Year, StartDate, EndDate, Room, BuildingName, DaysOfWeek, StartTime, EndTime, MaxEnrollment)
VALUES
(11, 5, 'Spring', 2024, '2024-01-16', '2024-05-03', '301', 'Liberal Arts Building', 'MWF', '09:00:00', '09:50:00', 30),
(12, 5, 'Spring', 2024, '2024-01-16', '2024-05-03', '302', 'Liberal Arts Building', 'TR', '11:00:00', '12:15:00', 25),
(13, 6, 'Spring', 2024, '2024-01-16', '2024-05-03', '101', 'Social Sciences Building', 'MWF', '10:00:00', '10:50:00', 40),
(14, 6, 'Spring', 2024, '2024-01-16', '2024-05-03', '102', 'Social Sciences Building', 'TR', '13:00:00', '14:15:00', 35),
(15, 7, 'Spring', 2024, '2024-01-16', '2024-05-03', '301', 'Science Building', 'MWF', '13:00:00', '13:50:00', 30),
(16, 7, 'Spring', 2024, '2024-01-16', '2024-05-03', '302', 'Science Building', 'TR', '15:00:00', '16:15:00', 25),
(17, 8, 'Spring', 2024, '2024-01-16', '2024-05-03', '401', 'Science Building', 'MWF', '11:00:00', '11:50:00', 30),
(18, 8, 'Spring', 2024, '2024-01-16', '2024-05-03', '402', 'Science Building', 'TR', '09:00:00', '10:15:00', 25);
GO

-- INSERT 100 random students 
-- First, create a temporary procedure to generate random students
CREATE PROCEDURE GenerateRandomStudents
    @Count INT
AS
BEGIN
    DECLARE @i INT = 1;
    DECLARE @FirstNames TABLE (FirstName NVARCHAR(50));
    DECLARE @LastNames TABLE (LastName NVARCHAR(50));
    
    -- Insert sample first names
    INSERT INTO @FirstNames VALUES 
    ('James'), ('John'), ('Robert'), ('Michael'), ('William'), ('David'), ('Richard'), ('Joseph'), ('Thomas'), ('Charles'),
    ('Mary'), ('Patricia'), ('Jennifer'), ('Linda'), ('Elizabeth'), ('Barbara'), ('Susan'), ('Jessica'), ('Sarah'), ('Karen'),
    ('Daniel'), ('Matthew'), ('Anthony'), ('Mark'), ('Donald'), ('Steven'), ('Paul'), ('Andrew'), ('Joshua'), ('Kenneth'),
    ('Emily'), ('Emma'), ('Madison'), ('Olivia'), ('Hannah'), ('Abigail'), ('Isabella'), ('Samantha'), ('Elizabeth'), ('Alexis');
    
    -- Insert sample last names
    INSERT INTO @LastNames VALUES 
    ('Smith'), ('Johnson'), ('Williams'), ('Jones'), ('Brown'), ('Davis'), ('Miller'), ('Wilson'), ('Moore'), ('Taylor'),
    ('Anderson'), ('Thomas'), ('Jackson'), ('White'), ('Harris'), ('Martin'), ('Thompson'), ('Garcia'), ('Martinez'), ('Robinson'),
    ('Clark'), ('Rodriguez'), ('Lewis'), ('Lee'), ('Walker'), ('Hall'), ('Allen'), ('Young'), ('Hernandez'), ('King'),
    ('Wright'), ('Lopez'), ('Hill'), ('Scott'), ('Green'), ('Adams'), ('Baker'), ('Gonzalez'), ('Nelson'), ('Carter');
    
    -- Generate the specified number of students
    WHILE @i <= @Count
    BEGIN
        DECLARE @FirstName NVARCHAR(50);
        DECLARE @LastName NVARCHAR(50);
        DECLARE @Email NVARCHAR(100);
        DECLARE @DOB DATE;
        DECLARE @Gender NVARCHAR(10);
        DECLARE @MajorID INT;
        
        -- Select random first and last name
        SELECT TOP 1 @FirstName = FirstName FROM @FirstNames ORDER BY NEWID();
        SELECT TOP 1 @LastName = LastName FROM @LastNames ORDER BY NEWID();
        
        -- Generate email
        SET @Email = LOWER(SUBSTRING(@FirstName, 1, 1) + @LastName + CAST(@i AS NVARCHAR(10)) + '@university.edu');
        
        -- Generate random birth date (18-25 years old)
        SET @DOB = DATEADD(YEAR, -18 - (CAST(RAND() * 7 AS INT)), GETDATE());
        
        -- Assign gender randomly
        SET @Gender = CASE WHEN RAND() > 0.5 THEN 'Male' ELSE 'Female' END;
        
        -- Assign major randomly (between 1 and 18)
        SET @MajorID = CAST(RAND() * 18 + 1 AS INT);
        
        -- Insert the student
        INSERT INTO Students (FirstName, LastName, Email, DateOfBirth, Gender, Phone, Address, EnrollmentDate, MajorID)
        VALUES (
            @FirstName, 
            @LastName,
            @Email,
            @DOB,
            @Gender,
            '555-' + CAST(100 + CAST(RAND() * 900 AS INT) AS NVARCHAR(3)) + '-' + CAST(1000 + CAST(RAND() * 9000 AS INT) AS NVARCHAR(4)),
            CAST(100 + CAST(RAND() * 9900 AS INT) AS NVARCHAR(10)) + ' ' + 
                CASE CAST(RAND() * 4 AS INT)
                    WHEN 0 THEN 'Main'
                    WHEN 1 THEN 'Oak'
                    WHEN 2 THEN 'Maple'
                    ELSE 'Pine'
                END + ' ' +
                CASE CAST(RAND() * 4 AS INT)
                    WHEN 0 THEN 'Street'
                    WHEN 1 THEN 'Avenue'
                    WHEN 2 THEN 'Drive'
                    ELSE 'Road'
                END,
            DATEADD(DAY, -CAST(RAND() * 365 * 2 AS INT), GETDATE()),
            @MajorID
        );
        
        SET @i = @i + 1;
    END;
END;
GO

-- Execute the procedure to generate 100 students
EXEC GenerateRandomStudents @Count = 100;
GO

-- Drop the temporary procedure
DROP PROCEDURE GenerateRandomStudents;
GO

-- Generate enrollments (each student in 3-5 classes randomly)
DECLARE @CurrentStudentID INT = 1;
DECLARE @MaxStudentID INT;
SELECT @MaxStudentID = MAX(StudentID) FROM Students;

WHILE @CurrentStudentID <= @MaxStudentID
BEGIN
    DECLARE @NumClasses INT = 3 + CAST(RAND() * 3 AS INT); -- 3-5 classes
    DECLARE @ClassesEnrolled INT = 0;
    
    WHILE @ClassesEnrolled < @NumClasses
    BEGIN
        DECLARE @ClassID INT = CAST(RAND() * 18 + 1 AS INT);
        DECLARE @GradeID INT = CAST(RAND() * 13 + 1 AS INT);
        
        -- Only insert if this enrollment doesn't already exist
        IF NOT EXISTS (SELECT 1 FROM Enrollments WHERE StudentID = @CurrentStudentID AND ClassID = @ClassID)
        BEGIN
            INSERT INTO Enrollments (StudentID, ClassID, GradeID, EnrollmentDate)
            VALUES (@CurrentStudentID, @ClassID, @GradeID, DATEADD(DAY, -CAST(RAND() * 365 AS INT), GETDATE()));
            
            SET @ClassesEnrolled = @ClassesEnrolled + 1;
            
            -- Update the current enrollment count in the class
            UPDATE Classes 
            SET CurrentEnrollment = CurrentEnrollment + 1
            WHERE ClassID = @ClassID;
        END;
    END;
    
    SET @CurrentStudentID = @CurrentStudentID + 1;
END;
GO

-- Generate payments (1-3 payments per student)
DECLARE @CurrentStudentID INT = 1;
DECLARE @MaxStudentID INT;
SELECT @MaxStudentID = MAX(StudentID) FROM Students;

WHILE @CurrentStudentID <= @MaxStudentID
BEGIN
    DECLARE @NumPayments INT = 1 + CAST(RAND() * 3 AS INT); -- 1-3 payments
    DECLARE @PaymentsMade INT = 0;
    
    WHILE @PaymentsMade < @NumPayments
    BEGIN
        DECLARE @Amount DECIMAL(10, 2) = 1000 + CAST(RAND() * 5000 AS DECIMAL(10, 2));
        DECLARE @PaymentDate DATETIME = DATEADD(DAY, -CAST(RAND() * 365 AS INT), GETDATE());
        DECLARE @PaymentMethod NVARCHAR(50) = CASE CAST(RAND() * 3 AS INT)
                                              WHEN 0 THEN 'Credit Card'
                                              WHEN 1 THEN 'Bank Transfer'
                                              ELSE 'Check'
                                              END;
        
        INSERT INTO Payments (StudentID, Amount, PaymentDate, PaymentMethod, ReferenceNumber)
        VALUES (
            @CurrentStudentID,
            @Amount,
            @PaymentDate,
            @PaymentMethod,
            'REF-' + CAST(10000 + CAST(RAND() * 90000 AS INT) AS NVARCHAR(10))
        );
        
        SET @PaymentsMade = @PaymentsMade + 1;
    END;
    
    SET @CurrentStudentID = @CurrentStudentID + 1;
END;
GO

PRINT 'Sample data generation complete: 100 students with related records';
GO