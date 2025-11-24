USE DM_FTI_DW;
GO

-- Dim ProgramStudi
MERGE dbo.Dim_ProgramStudi AS tgt
USING (
    SELECT DISTINCT id_prodi, nama_prodi, jenjang, fakultas FROM stg.ProgramStudi
) AS src
ON tgt.id_prodi = src.id_prodi
WHEN MATCHED THEN UPDATE SET
    tgt.nama_prodi = src.nama_prodi,
    tgt.jenjang = src.jenjang,
    tgt.fakultas = src.fakultas,
    tgt.updated_date = GETDATE()
WHEN NOT MATCHED THEN
    INSERT (id_prodi, nama_prodi, jenjang, fakultas)
    VALUES (src.id_prodi, src.nama_prodi, src.jenjang, src.fakultas);
GO

-- Dim Mahasiswa
MERGE dbo.Dim_Mahasiswa AS tgt
USING (
    SELECT nim, nama_mahasiswa, jenis_kelamin, angkatan, status, kode_prodi FROM stg.Mahasiswa
) AS src
ON tgt.nim = src.nim
WHEN MATCHED THEN UPDATE SET
    tgt.nama_mahasiswa = src.nama_mahasiswa,
    tgt.jenis_kelamin = src.jenis_kelamin,
    tgt.angkatan = src.angkatan,
    tgt.status = src.status,
    tgt.sk_prodi = (SELECT sk_prodi FROM dbo.Dim_ProgramStudi WHERE id_prodi = src.kode_prodi),
    tgt.updated_date = GETDATE()
WHEN NOT MATCHED THEN
    INSERT (nim, nama_mahasiswa, jenis_kelamin, angkatan, status, sk_prodi)
    VALUES (
        src.nim, src.nama_mahasiswa, src.jenis_kelamin, src.angkatan, src.status,
        (SELECT sk_prodi FROM dbo.Dim_ProgramStudi WHERE id_prodi = src.kode_prodi)
    );
GO

-- Dim Prestasi
MERGE dbo.Dim_Prestasi AS tgt
USING (SELECT DISTINCT id_prestasi FROM stg.Prestasi) AS src
ON tgt.id_prestasi = src.id_prestasi
WHEN NOT MATCHED THEN
    INSERT (id_prestasi) VALUES (src.id_prestasi);
GO

-- Dim Anggaran
MERGE dbo.Dim_Anggaran AS tgt
USING (SELECT DISTINCT id_anggaran FROM stg.Anggaran) AS src
ON tgt.id_anggaran = src.id_anggaran
WHEN NOT MATCHED THEN
    INSERT (id_anggaran) VALUES (src.id_anggaran);
GO

-- Dim Akreditasi
MERGE dbo.Dim_Akreditasi AS tgt
USING (
    SELECT DISTINCT id_akreditasi, status_akreditasi, nilai_akreditasi, lembaga FROM stg.Akreditasi
) AS src
ON tgt.id_akreditasi = src.id_akreditasi
WHEN MATCHED THEN UPDATE SET
    tgt.status_akreditasi = src.status_akreditasi,
    tgt.nilai_akreditasi = src.nilai_akreditasi,
    tgt.lembaga = src.lembaga
WHEN NOT MATCHED THEN
    INSERT (id_akreditasi, status_akreditasi, nilai_akreditasi, lembaga)
    VALUES (src.id_akreditasi, src.status_akreditasi, src.nilai_akreditasi, src.lembaga);
GO

-- Dim Dosen
MERGE dbo.Dim_Dosen AS tgt
USING (
    SELECT DISTINCT nidn, nama_dosen, kode_prodi FROM stg.Dosen
) AS src
ON tgt.nidn = src.nidn
WHEN MATCHED THEN UPDATE SET
    tgt.nama_dosen = src.nama_dosen,
    tgt.sk_prodi = (SELECT sk_prodi FROM dbo.Dim_ProgramStudi WHERE id_prodi = src.kode_prodi),
    tgt.updated_date = GETDATE()
WHEN NOT MATCHED THEN
    INSERT (nidn, nama_dosen, sk_prodi)
    VALUES (
        src.nidn, src.nama_dosen,
        (SELECT sk_prodi FROM dbo.Dim_ProgramStudi WHERE id_prodi = src.kode_prodi)
    );
GO

-- Dim Waktu (generate per year from staging)
INSERT INTO dbo.Dim_Waktu (sk_waktu, tanggal, tahun, semester, bulan, nama_bulan)
SELECT DISTINCT
    CAST(CONCAT(tahun, '0101') AS INT) AS sk_waktu,
    CAST(CONCAT(tahun, '-01-01') AS DATE) AS tanggal,
    tahun,
    'Genap' AS semester,
    1 AS bulan,
    'Januari' AS nama_bulan
FROM (
    SELECT tahun FROM stg.Anggaran
    UNION
    SELECT tahun FROM stg.Akreditasi
    UNION
    SELECT tahun FROM stg.Dosen
    UNION
    SELECT tahun FROM stg.Akademik
) AS x
WHERE NOT EXISTS (SELECT 1 FROM dbo.Dim_Waktu w WHERE w.tahun = x.tahun);
GO

-- Fact_Prestasi
INSERT INTO dbo.Fact_Prestasi (sk_prestasi, sk_mahasiswa, sk_prodi, sk_waktu)
SELECT
    dp.sk_prestasi,
    dm.sk_mahasiswa,
    pr.sk_prodi,
    dw.sk_waktu
FROM stg.Prestasi s
JOIN dbo.Dim_Prestasi dp ON dp.id_prestasi = s.id_prestasi
JOIN dbo.Dim_Mahasiswa dm ON dm.nim = s.nim
JOIN dbo.Dim_ProgramStudi pr ON pr.id_prodi = s.kode_prodi
JOIN dbo.Dim_Waktu dw ON dw.tanggal = s.tanggal_prestasi;
GO

-- Fact_Anggaran
INSERT INTO dbo.Fact_Anggaran (sk_anggaran, sk_prodi, sk_waktu, total_anggaran)
SELECT
    da.sk_anggaran,
    dp.sk_prodi,
    dw.sk_waktu,
    s.total_anggaran
FROM stg.Anggaran s
JOIN dbo.Dim_Anggaran da ON da.id_anggaran = s.id_anggaran
JOIN dbo.Dim_ProgramStudi dp ON dp.id_prodi = s.kode_prodi
JOIN dbo.Dim_Waktu dw ON dw.tahun = s.tahun;
GO

-- Fact_Akreditasi
INSERT INTO dbo.Fact_Akreditasi (sk_akreditasi, sk_prodi, sk_waktu, nilai_akreditasi)
SELECT
    da.sk_akreditasi,
    dp.sk_prodi,
    dw.sk_waktu,
    s.nilai_akreditasi
FROM stg.Akreditasi s
JOIN dbo.Dim_Akreditasi da ON da.id_akreditasi = s.id_akreditasi
JOIN dbo.Dim_ProgramStudi dp ON dp.id_prodi = s.kode_prodi
JOIN dbo.Dim_Waktu dw ON dw.tahun = s.tahun;
GO

-- Fact_Akademik
INSERT INTO dbo.Fact_Akademik (sk_prodi, sk_waktu, jumlah_mahasiswa_baru, rata_rata_ipk)
SELECT
    dp.sk_prodi,
    dw.sk_waktu,
    s.jumlah_mahasiswa_baru,
    s.rata_rata_ipk
FROM stg.Akademik s
JOIN dbo.Dim_ProgramStudi dp ON dp.id_prodi = s.kode_prodi
JOIN dbo.Dim_Waktu dw ON dw.tahun = s.tahun;
GO

-- Fact_Dosen
INSERT INTO dbo.Fact_Dosen (sk_prodi, sk_waktu, jumlah_dosen, jumlah_mahasiswa, rasio_dosen_mahasiswa)
SELECT
    dp.sk_prodi,
    dw.sk_waktu,
    s.jumlah_dosen,
    s.jumlah_mahasiswa,
    s.rasio_dosen_mahasiswa
FROM stg.Dosen s
JOIN dbo.Dim_ProgramStudi dp ON dp.id_prodi = s.kode_prodi
JOIN dbo.Dim_Waktu dw ON dw.tahun = s.tahun;
GO
