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

------------------------------------------------------------
-- Load_Dim_Waktu (Full Calendar)
------------------------------------------------------------
CREATE OR ALTER PROCEDURE etl.Load_Dim_Waktu
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Start DATE = '2020-01-01', @End DATE = '2025-12-31';

    ;WITH Calendar AS (
        SELECT @Start AS dt
        UNION ALL
        SELECT DATEADD(DAY,1,dt)
        FROM Calendar
        WHERE dt < @End
    )
    INSERT INTO dbo.Dim_Waktu (sk_waktu, tanggal, tahun, semester, bulan, nama_bulan)
    SELECT
        CONVERT(INT, FORMAT(dt,'yyyyMMdd')),
        dt,
        YEAR(dt),
        CASE WHEN MONTH(dt)<=6 THEN 'Genap' ELSE 'Ganjil' END,
        MONTH(dt),
        DATENAME(MONTH,dt)
    FROM Calendar
    WHERE NOT EXISTS (SELECT 1 FROM dbo.Dim_Waktu w WHERE w.tanggal = dt)
    OPTION (MAXRECURSION 6000);
END;
GO

------------------------------------------------------------
-- FACT LOADS (unchanged, compatible)
------------------------------------------------------------

CREATE OR ALTER PROCEDURE etl.Load_Fact_Prestasi
AS
BEGIN
    INSERT INTO dbo.Fact_Prestasi (sk_prestasi, sk_mahasiswa, sk_prodi, sk_waktu, created_date)
    SELECT dp.sk_prestasi, dm.sk_mahasiswa, pr.sk_prodi, dw.sk_waktu, GETDATE()
    FROM stg.Prestasi s
    LEFT JOIN dbo.Dim_Prestasi dp ON dp.id_prestasi = s.id_prestasi
    LEFT JOIN dbo.Dim_Mahasiswa dm ON dm.nim = s.nim AND dm.is_current = 1
    LEFT JOIN dbo.Dim_ProgramStudi pr ON pr.id_prodi = s.kode_prodi
    LEFT JOIN dbo.Dim_Waktu dw ON dw.tahun = YEAR(s.tanggal_prestasi)
    WHERE dp.sk_prestasi IS NOT NULL AND dm.sk_mahasiswa IS NOT NULL AND pr.sk_prodi IS NOT NULL AND dw.sk_waktu IS NOT NULL;
END;
GO

CREATE OR ALTER PROCEDURE etl.Load_Fact_Anggaran
AS
BEGIN
    INSERT INTO dbo.Fact_Anggaran (sk_anggaran, sk_prodi, sk_waktu, total_anggaran, created_date)
    SELECT da.sk_anggaran, dp.sk_prodi, dw.sk_waktu, s.total_anggaran, GETDATE()
    FROM stg.Anggaran s
    LEFT JOIN dbo.Dim_Anggaran da ON da.id_anggaran = s.id_anggaran
    LEFT JOIN dbo.Dim_ProgramStudi dp ON dp.id_prodi = s.kode_prodi
    LEFT JOIN dbo.Dim_Waktu dw ON dw.tahun = s.tahun
    WHERE da.sk_anggaran IS NOT NULL AND dp.sk_prodi IS NOT NULL AND dw.sk_waktu IS NOT NULL;
END;
GO

CREATE OR ALTER PROCEDURE etl.Load_Fact_Akreditasi
AS
BEGIN
    INSERT INTO dbo.Fact_Akreditasi (sk_akreditasi, sk_prodi, sk_waktu, created_date)
    SELECT dak.sk_akreditasi, dp.sk_prodi, dw.sk_waktu, GETDATE()
    FROM stg.Akreditasi s
    LEFT JOIN dbo.Dim_Akreditasi dak ON dak.id_akreditasi = s.id_akreditasi
    LEFT JOIN dbo.Dim_ProgramStudi dp ON dp.id_prodi = s.id_prodi
    LEFT JOIN dbo.Dim_Waktu dw ON dw.tahun = s.tahun
    WHERE dak.sk_akreditasi IS NOT NULL AND dp.sk_prodi IS NOT NULL AND dw.sk_waktu IS NOT NULL;
END;
GO

CREATE OR ALTER PROCEDURE etl.Load_Fact_Akademik
AS
BEGIN
    INSERT INTO dbo.Fact_Akademik (sk_prodi, sk_waktu, jumlah_mahasiswa_baru, rata_rata_ipk, created_date)
    SELECT dp.sk_prodi, dw.sk_waktu, s.jumlah_mahasiswa_baru, s.rata_rata_ipk, GETDATE()
    FROM stg.Akademik s
    LEFT JOIN dbo.Dim_ProgramStudi dp ON dp.id_prodi = s.kode_prodi
    LEFT JOIN dbo.Dim_Waktu dw ON dw.tahun = s.tahun
    WHERE dp.sk_prodi IS NOT NULL AND dw.sk_waktu IS NOT NULL;
END;
GO

CREATE OR ALTER PROCEDURE etl.Load_Fact_Dosen
AS
BEGIN
    INSERT INTO dbo.Fact_Dosen (sk_prodi, sk_waktu, jumlah_dosen, jumlah_mahasiswa, rasio_dosen_mahasiswa, created_date)
    SELECT dp.sk_prodi, dw.sk_waktu, s.jumlah_dosen, s.jumlah_mahasiswa, s.rasio_dosen_mahasiswa, GETDATE()
    FROM stg.Dosen s
    LEFT JOIN dbo.Dim_ProgramStudi dp ON dp.id_prodi = s.kode_prodi
    LEFT JOIN dbo.Dim_Waktu dw ON dw.tahun = s.tahun
    WHERE dp.sk_prodi IS NOT NULL AND dw.sk_waktu IS NOT NULL;
END;
GO

------------------------------------------------------------
-- MASTER ETL
------------------------------------------------------------
CREATE OR ALTER PROCEDURE etl.usp_Master_ETL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;

        EXEC etl.Load_Dim_ProgramStudi;
        EXEC etl.Load_Dim_Mahasiswa;
        EXEC etl.Load_Dim_Prestasi;
        EXEC etl.Load_Dim_Anggaran;
        EXEC etl.Load_Dim_Akreditasi;
        EXEC etl.Load_Dim_Dosen;
        EXEC etl.Load_Dim_Waktu;

        EXEC etl.Load_Fact_Prestasi;
        EXEC etl.Load_Fact_Anggaran;
        EXEC etl.Load_Fact_Akreditasi;
        EXEC etl.Load_Fact_Akademik;
        EXEC etl.Load_Fact_Dosen;

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN;

        DECLARE @ErrMsg NVARCHAR(2000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH;
END;
GO
