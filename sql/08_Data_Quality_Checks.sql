-- Completeness
-- Missing key attributes
SELECT COUNT(*) AS MissingNIM
FROM dbo.Dim_Mahasiswa
WHERE nim IS NULL OR nim = '';
GO

SELECT COUNT(*) AS MissingNamaMahasiswa
FROM dbo.Dim_Mahasiswa
WHERE nama_mahasiswa IS NULL OR nama_mahasiswa = '';
GO

-- Missing Prestasi Dates in staging
SELECT COUNT(*) AS MissingTanggalPrestasi
FROM stg.Prestasi
WHERE tanggal_prestasi IS NULL;
GO

-- Missing Anggaran Amount
SELECT COUNT(*) AS MissingTotalAnggaran
FROM stg.Anggaran
WHERE total_anggaran IS NULL;
GO

-- Duplicate Checks
-- Duplicate Mahasiswa (should not happen)
SELECT nim, COUNT(*) AS dupe_count
FROM dbo.Dim_Mahasiswa
GROUP BY nim
HAVING COUNT(*) > 1;
GO

-- Duplicate Prestasi IDs
SELECT id_prestasi, COUNT(*) AS dupe_count
FROM dbo.Dim_Prestasi
GROUP BY id_prestasi
HAVING COUNT(*) > 1;
GO

-- Duplicate Prodi
SELECT id_prodi, COUNT(*) AS dupe_count
FROM dbo.Dim_ProgramStudi
GROUP BY id_prodi
HAVING COUNT(*) > 1;
GO

-- Referential Integrity Checks
-- Fact_Prestasi → Dim_Mahasiswa
SELECT COUNT(*) AS Orphan_FactPrestasi_Mahasiswa
FROM dbo.Fact_Prestasi fp
LEFT JOIN dbo.Dim_Mahasiswa dm ON fp.sk_mahasiswa = dm.sk_mahasiswa
WHERE dm.sk_mahasiswa IS NULL;
GO

-- Fact_Prestasi → Dim_Prestasi
SELECT COUNT(*) AS Orphan_FactPrestasi_Prestasi
FROM dbo.Fact_Prestasi fp
LEFT JOIN dbo.Dim_Prestasi dp ON fp.sk_prestasi = dp.sk_prestasi
WHERE dp.sk_prestasi IS NULL;
GO

-- Fact_Anggaran → Dim_ProgramStudi
SELECT COUNT(*) AS Orphan_FactAnggaran_Prodi
FROM dbo.Fact_Anggaran fa
LEFT JOIN dbo.Dim_ProgramStudi dp ON fa.sk_prodi = dp.sk_prodi
WHERE dp.sk_prodi IS NULL;
GO

-- Fact_Akreditasi → Dim_Akreditasi
SELECT COUNT(*) AS Orphan_FactAkreditasi
FROM dbo.Fact_Akreditasi fa
LEFT JOIN dbo.Dim_Akreditasi da ON fa.sk_akreditasi = da.sk_akreditasi
WHERE da.sk_akreditasi IS NULL;
GO

-- Range Checks
-- Akreditasi Score should be between 0 and 4
SELECT *
FROM dbo.Dim_Akreditasi
WHERE nilai_akreditasi < 0 OR nilai_akreditasi > 4;
GO

-- Anggaran should never be negative
SELECT *
FROM dbo.Fact_Anggaran
WHERE total_anggaran < 0;
GO

-- Timeliness
SELECT 
    MIN(tahun) AS tahun_min,
    MAX(tahun) AS tahun_max
FROM dbo.Dim_Waktu;
GO

-- SCD Validity Checks
-- Valid SCD1 Check: Ensure no duplicate business keys
SELECT nim
FROM dbo.Dim_Mahasiswa
GROUP BY nim
HAVING COUNT(*) > 1;
GO
