CREATE PROCEDURE etl.Load_Dim_Mahasiswa
AS
BEGIN
    SET NOCOUNT ON;

    MERGE dbo.Dim_Mahasiswa AS target
    USING (
        SELECT nim, nama_mahasiswa, jenis_kelamin, angkatan, status, kode_prodi
        FROM stg.Mahasiswa
    ) AS src
    ON target.nim = src.nim AND target.IsCurrent = 1

    WHEN MATCHED AND (
        target.nama_mahasiswa <> src.nama_mahasiswa OR
        target.jenis_kelamin <> src.jenis_kelamin OR
        target.angkatan <> src.angkatan OR
        target.status <> src.status OR
        target.id_prodi <> src.kode_prodi
    )
    THEN UPDATE SET 
        target.IsCurrent = 0,
        target.ExpiryDate = GETDATE();

    WHEN NOT MATCHED THEN
        INSERT (nim, nama_mahasiswa, jenis_kelamin, angkatan, status, sk_prodi, EffectiveDate, IsCurrent)
        VALUES (
            src.nim, src.nama_mahasiswa, src.jenis_kelamin, src.angkatan, src.status,
            (SELECT sk_prodi FROM dbo.Dim_ProgramStudi WHERE id_prodi = src.kode_prodi),
            GETDATE(), 1
        );
END;
GO