-- Simple Performance Comparison With and Without Index
-- Shows timing difference for email lookups

USE [University Management System];
GO

PRINT '---------------------------------------------------------------------';
PRINT 'SIMPLE INDEX PERFORMANCE COMPARISON';
PRINT '---------------------------------------------------------------------';

-- Create temporary test table with copy of student data
SELECT * INTO #TempStudents FROM Students;

-- Get a random email to search for
DECLARE @TestEmail NVARCHAR(100);
SELECT TOP 1 @TestEmail = Email FROM #TempStudents ORDER BY NEWID();
PRINT 'Searching for email: ' + @TestEmail;
PRINT '';

-- Test WITHOUT index
PRINT 'WITHOUT INDEX:';
DECLARE @StartTime1 DATETIME = GETDATE();

-- Run query once without index
SELECT StudentID, FirstName, LastName 
FROM #TempStudents 
WHERE Email = @TestEmail;

DECLARE @WithoutIndexTime INT = DATEDIFF(MILLISECOND, @StartTime1, GETDATE());
PRINT 'Time: ' + CAST(@WithoutIndexTime AS VARCHAR) + ' ms';
PRINT '';

-- Create index on the test table
PRINT 'Creating index on Email column...';
CREATE NONCLUSTERED INDEX IX_Temp_Email ON #TempStudents(Email);
PRINT '';

-- Test WITH index
PRINT 'WITH INDEX:';
DECLARE @StartTime2 DATETIME = GETDATE();

-- Run query once with index
SELECT StudentID, FirstName, LastName 
FROM #TempStudents 
WHERE Email = @TestEmail;

DECLARE @WithIndexTime INT = DATEDIFF(MILLISECOND, @StartTime2, GETDATE());
PRINT 'Time: ' + CAST(@WithIndexTime AS VARCHAR) + ' ms';
PRINT '';

-- Show comparison
PRINT 'COMPARISON:';
PRINT 'Without index: ' + CAST(@WithoutIndexTime AS VARCHAR) + ' ms';
PRINT 'With index:    ' + CAST(@WithIndexTime AS VARCHAR) + ' ms';

-- Calculate improvement if possible
IF @WithoutIndexTime > 0 AND @WithoutIndexTime > @WithIndexTime
BEGIN
    DECLARE @Improvement FLOAT = (CAST(@WithoutIndexTime - @WithIndexTime AS FLOAT) / @WithoutIndexTime) * 100;
    PRINT 'Performance improvement: ' + CAST(ROUND(@Improvement, 2) AS VARCHAR) + '%';
END

-- Clean up
DROP TABLE #TempStudents;
GO 