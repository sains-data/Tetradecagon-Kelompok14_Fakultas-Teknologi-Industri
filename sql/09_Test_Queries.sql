-- Simple Aggregation Tests
SELECT 
    w.tahun, 
    SUM(fp.jumlah_prestasi) AS total_prestasi
FROM Fact_Prestasi fp
JOIN Dim_Waktu w 
    ON fp.sk_waktu = w.sk_waktu
GROUP BY w.tahun
ORDER BY w.tahun;

SELECT 
    dp.nama_prodi, 
    SUM(fa.total_anggaran) AS total_anggaran
FROM Fact_Anggaran fa
JOIN Dim_ProgramStudi dp 
    ON dp.sk_prodi = fa.sk_prodi
GROUP BY dp.nama_prodi
ORDER BY dp.nama_prodi;

-- Complex Join Tests
SELECT 
    dm.nama_mahasiswa,
    dp.nama_prodi,
    w.tahun,
    COUNT(fp.sk_prestasi) AS jumlah_prestasi
FROM Fact_Prestasi fp
JOIN Dim_Mahasiswa dm ON fp.sk_mahasiswa = dm.sk_mahasiswa
JOIN Dim_ProgramStudi dp ON fp.sk_prodi = dp.sk_prodi
JOIN Dim_Waktu w ON fp.sk_waktu = w.sk_waktu
GROUP BY 
    dm.nama_mahasiswa, 
    dp.nama_prodi, 
    w.tahun
ORDER BY 
    dm.nama_mahasiswa, 
    w.tahun;

-- Drill-down Analysis
SELECT 
    dp.nama_prodi,
    w.tahun,
    w.semester,
    AVG(fak.rata_rata_ipk) AS ipk_rata_rata
FROM Fact_Akademik fak
JOIN Dim_ProgramStudi dp ON dp.sk_prodi = fak.sk_prodi
JOIN Dim_Waktu w ON w.sk_waktu = fak.sk_waktu
GROUP BY 
    dp.nama_prodi, 
    w.tahun, 
    w.semester
ORDER BY 
    dp.nama_prodi, 
    w.tahun, 
    w.semester;

-- Full Scan Report
SELECT *
FROM Fact_Anggaran
ORDER BY sk_waktu, sk_prodi;

-- Index Stress Test
SELECT 
    dp.nama_prodi, 
    SUM(fd.jumlah_dosen) AS total_dosen
FROM Fact_Dosen fd
JOIN Dim_ProgramStudi dp 
    ON dp.sk_prodi = fd.sk_prodi
GROUP BY dp.nama_prodi
ORDER BY dp.nama_prodi
