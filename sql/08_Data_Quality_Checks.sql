– Completeness
SELECT COUNT(*) AS MissingNIM
FROM dbo.Dim_Mahasiswa
WHERE nim IS NULL OR nim = '';

SELECT COUNT(*) AS MissingTanggalPrestasi
FROM stg.Prestasi
WHERE tanggal_prestasi IS NULL;

– Duplicate Checks
SELECT nim, COUNT(*) AS dupe_count
FROM dbo.Dim_Mahasiswa
GROUP BY nim
HAVING COUNT(*) > 1;

SELECT id_prestasi, COUNT(*) AS dupe_count
FROM dbo.Dim_Prestasi
GROUP BY id_prestasi
HAVING COUNT(*) > 1;

– Referential Integrity Checks
SELECT COUNT(*) AS Orphan_FactPrestasi_Mahasiswa
FROM dbo.Fact_Prestasi fp
LEFT JOIN dbo.Dim_Mahasiswa dm ON fp.sk_mahasiswa = dm.sk_mahasiswa
WHERE dm.sk_mahasiswa IS NULL;

SELECT COUNT(*) AS Orphan_FactAnggaran_Prodi
FROM dbo.Fact_Anggaran fa
LEFT JOIN dbo.Dim_ProgramStudi dp ON fa.sk_prodi = dp.sk_prodi
WHERE dp.sk_prodi IS NULL;

– Range Checks
SELECT *
FROM dbo.Dim_Akreditasi
WHERE nilai_akreditasi < 0 OR nilai_akreditasi > 4;

SELECT *
FROM dbo.Fact_Anggaran
WHERE total_anggaran < 0;

– Timeliness
SELECT MIN(tahun) AS tahun_min, MAX(tahun) AS tahun_max
FROM dbo.Dim_Waktu;

– SCD Validity Checks
SELECT nim
FROM dbo.Dim_Mahasiswa
GROUP BY nim
HAVING SUM(CASE WHEN IsCurrent = 1 THEN 1 ELSE 0 END) <> 1;
