CREATE PROCEDURE etl.Load_Dim_Mahasiswa
AS
BEGIN
    SET NOCOUNT ON;

    MERGE dbo.Dim_Mahasiswa AS target
    USING (
        SELECT 
            nim, 
            nama_mahasiswa,
            jenis_kelamin,
            angkatan,
            status,
            kode_prodi
        FROM stg.Mahasiswa
    ) AS src
        ON target.nim = src.nim

    WHEN MATCHED THEN
        UPDATE SET
            target.nama_mahasiswa = src.nama_mahasiswa,
            target.jenis_kelamin = src.jenis_kelamin,
            target.angkatan = src.angkatan,
            target.status = src.status,
            target.sk_prodi = (
                SELECT sk_prodi 
                FROM dbo.Dim_ProgramStudi 
                WHERE id_prodi = src.kode_prodi
            ),
            target.updated_date = GETDATE()

    WHEN NOT MATCHED THEN
        INSERT (nim, nama_mahasiswa, jenis_kelamin, angkatan, status, sk_prodi)
        VALUES (
            src.nim,
            src.nama_mahasiswa,
            src.jenis_kelamin,
            src.angkatan,
            src.status,
            (SELECT sk_prodi FROM dbo.Dim_ProgramStudi WHERE id_prodi = src.kode_prodi)
        );
END;
GO
