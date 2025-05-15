# University Management System Database

A comprehensive SQL Server database for managing university operations, including students, courses, instructors, and enrollments.

## Database Backup and Restore Guide

### Restoring from Backup

1. **Obtain the backup file** (.bak) of the University Management System database
2. **Restore the backup** in SQL Server Management Studio:
   - Right-click on "Databases" → Select "Restore Database..."
   - Choose "Device" and browse to the .bak file
   - Verify database name is "[University Management System]"
   - Click "OK" to restore

### Important Post-Restore Steps

After restoring the database, you must recreate server logins since these are NOT included in the backup:

1. **Run security scripts** located in the `08_Security` folder:

   ```sql
   USE [University Management System];
   -- Run 01_Roles_Permissions.sql first
   ```

2. **Verify security setup** with the test script:
   ```sql
   -- Run 02_Test_Roles.sql to confirm permissions work
   ```

### Common Issues After Restore

1. **Orphaned Users**: If you see errors about users not linked to logins, run:

   ```sql
   USE [University Management System];
   EXEC sp_change_users_login 'Report'; -- Identifies orphaned users
   EXEC sp_change_users_login 'Auto_Fix', 'TestStudent'; -- Fixes mapping for TestStudent
   EXEC sp_change_users_login 'Auto_Fix', 'TestInstructor'; -- Fixes mapping for TestInstructor
   EXEC sp_change_users_login 'Auto_Fix', 'TestAdmin'; -- Fixes mapping for TestAdmin
   ```

2. **Missing Logins**: The security scripts will recreate these, but if you get errors:
   ```sql
   -- Create server logins manually if needed
   CREATE LOGIN TestStudent WITH PASSWORD = 'Student123!';
   CREATE LOGIN TestInstructor WITH PASSWORD = 'Instructor123!';
   CREATE LOGIN TestAdmin WITH PASSWORD = 'Admin123!';
   ```

## Database Structure

The database contains the following components:

- **Tables**: Students, Instructors, Courses, Classes, Enrollments, etc.
- **Stored Procedures**: For student registration and other operations
- **Triggers**: For automatic updates of ModifiedDate fields
- **Indexes**: For optimized query performance
- **Security Roles**: StudentRole, InstructorRole, and AdminRole

## Security Overview

The database includes a role-based security system:

- **StudentRole**: View-only access to most tables, can update own enrollments
- **InstructorRole**: Can view student data, update grades and class information
- **AdminRole**: Full control over all database objects

## Maintenance Recommendations

- Schedule regular backups of the database
- Run the indexing performance comparison script periodically
- Review security permissions when adding new features
