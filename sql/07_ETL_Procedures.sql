------------------------------------------------------------
-- SCHEMA INITIALIZATION (if not exists)
------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'etl')
    EXEC('CREATE SCHEMA etl');
GO

------------------------------------------------------------
-- Load_Dim_ProgramStudi
------------------------------------------------------------
CREATE OR ALTER PROCEDURE etl.Load_Dim_ProgramStudi
AS
BEGIN
    SET NOCOUNT ON;

    MERGE dbo.Dim_ProgramStudi AS tgt
    USING (
        SELECT DISTINCT id_prodi, nama_prodi, jenjang, fakultas
        FROM stg.ProgramStudi
    ) AS src
    ON tgt.id_prodi = src.id_prodi
    WHEN MATCHED THEN
        UPDATE SET
            tgt.nama_prodi = src.nama_prodi,
            tgt.jenjang = src.jenjang,
            tgt.fakultas = src.fakultas,
            tgt.updated_date = GETDATE()
    WHEN NOT MATCHED THEN
        INSERT (id_prodi, nama_prodi, jenjang, fakultas, created_date, updated_date)
        VALUES (src.id_prodi, src.nama_prodi, src.jenjang, src.fakultas, GETDATE(), GETDATE());
END;
GO

------------------------------------------------------------
-- SCD TYPE-2 Enhanced Load_Dim_Mahasiswa
------------------------------------------------------------
ALTER TABLE dbo.Dim_Mahasiswa
ADD is_current BIT DEFAULT 1,
    valid_from DATETIME DEFAULT GETDATE(),
    valid_to DATETIME NULL;
GO

CREATE OR ALTER PROCEDURE etl.Load_Dim_Mahasiswa
AS
BEGIN
    SET NOCOUNT ON;

    MERGE dbo.Dim_Mahasiswa AS tgt
    USING (
        SELECT nim, nama_mahasiswa, jenis_kelamin, angkatan, status, kode_prodi
        FROM stg.Mahasiswa
    ) AS src
    ON tgt.nim = src.nim AND tgt.is_current = 1
    WHEN MATCHED AND (
        tgt.nama_mahasiswa <> src.nama_mahasiswa OR
        tgt.jenis_kelamin <> src.jenis_kelamin OR
        tgt.angkatan <> src.angkatan OR
        tgt.status <> src.status OR
        tgt.sk_prodi <> (SELECT sk_prodi FROM dbo.Dim_ProgramStudi WHERE id_prodi = src.kode_prodi)
    )
        THEN UPDATE SET tgt.is_current = 0, tgt.valid_to = GETDATE(), tgt.updated_date = GETDATE()
    WHEN NOT MATCHED THEN
        INSERT (
            nim, nama_mahasiswa, jenis_kelamin, angkatan, status,
            sk_prodi, created_date, updated_date, valid_from, is_current
        )
        VALUES (
            src.nim, src.nama_mahasiswa, src.jenis_kelamin, src.angkatan, src.status,
            (SELECT sk_prodi FROM dbo.Dim_ProgramStudi WHERE id_prodi = src.kode_prodi),
            GETDATE(), GETDATE(), GETDATE(), 1
        );
END;
GO

------------------------------------------------------------
-- Load_Dim_Prestasi (Enhanced)
------------------------------------------------------------
CREATE OR ALTER PROCEDURE etl.Load_Dim_Prestasi
AS
BEGIN
    SET NOCOUNT ON;

    MERGE dbo.Dim_Prestasi AS tgt
    USING (
        SELECT DISTINCT id_prestasi, nama_prestasi, jenis_prestasi, tingkat, penyelenggara
        FROM stg.Prestasi
    ) AS src
    ON tgt.id_prestasi = src.id_prestasi
    WHEN MATCHED THEN
        UPDATE SET
            tgt.nama_prestasi = src.nama_prestasi,
            tgt.jenis_prestasi = src.jenis_prestasi,
            tgt.tingkat = src.tingkat,
            tgt.penyelenggara = src.penyelenggara,
            tgt.updated_date = GETDATE()
    WHEN NOT MATCHED THEN
        INSERT (id_prestasi, nama_prestasi, jenis_prestasi, tingkat, penyelenggara, created_date, updated_date)
        VALUES (src.id_prestasi, src.nama_prestasi, src.jenis_prestasi, src.tingkat, src.penyelenggara, GETDATE(), GETDATE());
END;
GO

------------------------------------------------------------
-- Load_Dim_Anggaran (Enhanced)
------------------------------------------------------------
CREATE OR ALTER PROCEDURE etl.Load_Dim_Anggaran
AS
BEGIN
    SET NOCOUNT ON;

    MERGE dbo.Dim_Anggaran AS tgt
    USING (
        SELECT DISTINCT id_anggaran, kategori, keterangan
        FROM stg.Anggaran
    ) AS src
    ON tgt.id_anggaran = src.id_anggaran
    WHEN MATCHED THEN
        UPDATE SET
            tgt.kategori = src.kategori,
            tgt.keterangan = src.keterangan,
            tgt.updated_date = GETDATE()
    WHEN NOT MATCHED THEN
        INSERT (id_anggaran, kategori, keterangan, created_date, updated_date)
        VALUES (src.id_anggaran, src.kategori, src.keterangan, GETDATE(), GETDATE());
END;
GO

------------------------------------------------------------
-- Load_Dim_Akreditasi
------------------------------------------------------------
CREATE OR ALTER PROCEDURE etl.Load_Dim_Akreditasi
AS
BEGIN
    SET NOCOUNT ON;

    MERGE dbo.Dim_Akreditasi AS tgt
    USING (
        SELECT DISTINCT id_akreditasi, status_akreditasi, nilai_akreditasi, lembaga
        FROM stg.Akreditasi
    ) AS src
    ON tgt.id_akreditasi = src.id_akreditasi
    WHEN MATCHED THEN
        UPDATE SET
            tgt.status_akreditasi = src.status_akreditasi,
            tgt.nilai_akreditasi = src.nilai_akreditasi,
            tgt.lembaga = src.lembaga,
            tgt.updated_date = GETDATE()
    WHEN NOT MATCHED THEN
        INSERT (id_akreditasi, status_akreditasi, nilai_akreditasi, lembaga, created_date, updated_date)
        VALUES (src.id_akreditasi, src.status_akreditasi, src.nilai_akreditasi, src.lembaga, GETDATE(), GETDATE());
END;
GO

------------------------------------------------------------
-- Load_Dim_Dosen
------------------------------------------------------------
CREATE OR ALTER PROCEDURE etl.Load_Dim_Dosen
AS
BEGIN
    SET NOCOUNT ON;

    MERGE dbo.Dim_Dosen AS tgt
    USING (SELECT DISTINCT nidn, nama_dosen, kode_prodi FROM stg.Dosen) AS src
    ON tgt.nidn = src.nidn
    WHEN MATCHED THEN
        UPDATE SET
            tgt.nama_dosen = src.nama_dosen,
            tgt.sk_prodi = (SELECT sk_prodi FROM dbo.Dim_ProgramStudi WHERE id_prodi = src.kode_prodi),
            tgt.updated_date = GETDATE()
    WHEN NOT MATCHED THEN
        INSERT (nidn, nama_dosen, sk_prodi, created_date, updated_date)
        VALUES (src.nidn, src.nama_dosen, (SELECT sk_prodi FROM dbo.Dim_ProgramStudi WHERE id_prodi = src.kode_prodi), GETDATE(), GETDATE());
END;
GO

---------------------------
