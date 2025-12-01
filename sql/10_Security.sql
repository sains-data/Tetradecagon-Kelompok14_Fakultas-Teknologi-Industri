-- Create Roles
CREATE ROLE db_executive;
CREATE ROLE db_analyst;
CREATE ROLE db_viewer;
CREATE ROLE db_etl_operator;
GO

---------------------------------------------
-- Executive Permissions (Full Read + ETL)
---------------------------------------------
GRANT SELECT ON SCHEMA::dbo TO db_executive;
GRANT EXECUTE ON dbo.usp_Master_ETL TO db_executive;
GO

---------------------------------------------
-- Analyst Permissions (DW + Staging)
---------------------------------------------
GRANT SELECT ON SCHEMA::dbo TO db_analyst;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::stg TO db_analyst;
GO

---------------------------------------------
-- Viewer Permissions (Read-only Views)
---------------------------------------------
GRANT SELECT ON dbo.vw_Prestasi_Mahasiswa TO db_viewer;
GRANT SELECT ON dbo.vw_Program_Analytics TO db_viewer;
GRANT SELECT ON dbo.vw_Executive_Summary TO db_viewer;
GO

---------------------------------------------
-- ETL Operator Permissions
---------------------------------------------
GRANT EXECUTE ON SCHEMA::dbo TO db_etl_operator;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::stg TO db_etl_operator;
GRANT INSERT ON SCHEMA::dbo TO db_etl_operator;
GO

-- Create SQL Logins
CREATE LOGIN executive_user WITH PASSWORD = 'StrongP@ssw0rd!';
CREATE LOGIN analyst_user WITH PASSWORD = 'StrongP@ssw0rd!';
CREATE LOGIN viewer_user WITH PASSWORD = 'StrongP@ssw0rd!';
CREATE LOGIN etl_service WITH PASSWORD = 'StrongP@ssw0rd!';
GO

-- Create Database Users
USE DM_FTI_DW;
GO

CREATE USER executive_user FOR LOGIN executive_user;
CREATE USER analyst_user FOR LOGIN analyst_user;
CREATE USER viewer_user FOR LOGIN viewer_user;
CREATE USER etl_service FOR LOGIN etl_service;
GO

-- Assign to Roles
ALTER ROLE db_executive ADD MEMBER executive_user;
ALTER ROLE db_analyst ADD MEMBER analyst_user;
ALTER ROLE db_viewer ADD MEMBER viewer_user;
ALTER ROLE db_etl_operator ADD MEMBER etl_service;
GO


-- Masking Rules
ALTER TABLE dbo.Dim_Mahasiswa
ALTER COLUMN Email ADD MASKED WITH (FUNCTION = 'email()');

ALTER TABLE dbo.Dim_Mahasiswa
ALTER COLUMN Telp ADD MASKED WITH (FUNCTION = 'partial(0,"XXX-XXX-",4)');
GO

-- Grant UNMASK permission untuk specific roles
GRANT UNMASK TO db_executive;
GRANT UNMASK TO db_analyst;
GO

-- Create Audit Table
CREATE TABLE dbo.AuditLog (
    AuditID BIGINT IDENTITY(1,1) PRIMARY KEY,
    EventTime DATETIME2 DEFAULT SYSDATETIME(),
    UserName NVARCHAR(128) DEFAULT SUSER_SNAME(),
    EventType NVARCHAR(50), 
    SchemaName NVARCHAR(128),
    ObjectName NVARCHAR(128),
    SQLStatement NVARCHAR(MAX),
    RowsAffected INT,
    IPAddress VARCHAR(50),
    ApplicationName NVARCHAR(128) DEFAULT APP_NAME()
);
GO

-- Create Audit Trigger (example for Fact_Enrollment)
CREATE TRIGGER trg_Audit_Fact_Prestasi
ON dbo.Fact_Prestasi
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @EventType NVARCHAR(50);

    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
        SET @EventType = 'UPDATE';
    ELSE IF EXISTS (SELECT 1 FROM inserted)
        SET @EventType = 'INSERT';
    ELSE
        SET @EventType = 'DELETE';

    INSERT INTO dbo.AuditLog (EventType, SchemaName, ObjectName, RowsAffected)
    VALUES (@EventType, 'dbo', 'Fact_Prestasi', @@ROWCOUNT);
END;
GO

-- Enable SQL Server Audit (Server-level)
CREATE SERVER AUDIT DataWarehouse_Audit
TO FILE
(
    FILEPATH = N'D:\Audit\',
    MAXSIZE = 100 MB,
    MAX_ROLLOVER_FILES = 10
)
WITH (ON_FAILURE = CONTINUE);
GO

ALTER SERVER AUDIT DataWarehouse_Audit WITH (STATE = ON);
GO

-- Create Database Audit Specification
CREATE DATABASE AUDIT SPECIFICATION DataWarehouse_DB_Audit
FOR SERVER AUDIT DataWarehouse_Audit
ADD (SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo BY public);
GO

ALTER DATABASE AUDIT SPECIFICATION DataWarehouse_DB_Audit WITH (STATE = ON);
GO
