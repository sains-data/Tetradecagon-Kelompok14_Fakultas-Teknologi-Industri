CREATE TABLE etl.DataQualityAudit (
    audit_id INT IDENTITY PRIMARY KEY,
    check_name VARCHAR(200),
    table_name VARCHAR(200),
    issue_count INT,
    check_timestamp DATETIME DEFAULT GETDATE()
);
GO

CREATE PROCEDURE etl.Run_DataQualityChecks
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO etl.DataQualityAudit (check_name, table_name, issue_count)
    SELECT 
        'Missing NIM', 'Dim_Mahasiswa',
        (SELECT COUNT(*) FROM dbo.Dim_Mahasiswa WHERE nim IS NULL OR nim = '');

    INSERT INTO etl.DataQualityAudit (check_name, table_name, issue_count)
    SELECT 
        'Duplicate NIM', 'Dim_Mahasiswa',
        COUNT(*)
    FROM (
        SELECT nim FROM dbo.Dim_Mahasiswa GROUP BY nim HAVING COUNT(*) > 1
    ) x;

    INSERT INTO etl.DataQualityAudit (check_name, table_name, issue_count)
    SELECT 
        'Orphan FactPrestasi-Mahasiswa', 'Fact_Prestasi',
        COUNT(*)
    FROM dbo.Fact_Prestasi fp
    LEFT JOIN dbo.Dim_Mahasiswa dm ON fp.sk_mahasiswa = dm.sk_mahasiswa
    WHERE dm.sk_mahasiswa IS NULL;

END;
GO

IF EXISTS (
   SELECT 1 FROM etl.DataQualityAudit
   WHERE issue_count > 0
)
BEGIN
    RAISERROR ('DATA QUALITY ISSUE DETECTED!', 16, 1);
END
