-- Clustered Index for Fact_Prestasi (grain: mahasiswa–prestasi–waktu–prodi)
CREATE CLUSTERED INDEX CIX_Fact_Prestasi
ON dbo.Fact_Prestasi (sk_mahasiswa, sk_prestasi, sk_waktu, sk_prodi);
GO

CREATE CLUSTERED INDEX CIX_Fact_Anggaran
ON dbo.Fact_Anggaran (sk_prodi, sk_waktu, sk_anggaran);
GO

CREATE CLUSTERED INDEX CIX_Fact_Akreditasi
ON dbo.Fact_Akreditasi (sk_prodi, sk_waktu, sk_akreditasi);
GO

CREATE CLUSTERED INDEX CIX_Fact_Akademik
ON dbo.Fact_Akademik (sk_prodi, sk_waktu);
GO

CREATE CLUSTERED INDEX CIX_Fact_Dosen
ON dbo.Fact_Dosen (sk_prodi, sk_waktu, sk_dosen);
GO

------------------------------------------------------------
-- Index untuk Foreign Keys pada Fact_Prestasi (join optimization)
------------------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Fact_Prestasi_sk_waktu
ON dbo.Fact_Prestasi (sk_waktu);

CREATE NONCLUSTERED INDEX IX_Fact_Prestasi_sk_prodi
ON dbo.Fact_Prestasi (sk_prodi);

CREATE NONCLUSTERED INDEX IX_Fact_Prestasi_sk_mahasiswa
ON dbo.Fact_Prestasi (sk_mahasiswa);
GO


------------------------------------------------------------
-- Index untuk Foreign Keys pada Fact_Anggaran
------------------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Fact_Anggaran_sk_waktu
ON dbo.Fact_Anggaran (sk_waktu);

CREATE NONCLUSTERED INDEX IX_Fact_Anggaran_sk_prodi
ON dbo.Fact_Anggaran (sk_prodi);
GO


------------------------------------------------------------
-- Index untuk Foreign Keys pada Fact_Akreditasi
------------------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Fact_Akreditasi_sk_waktu
ON dbo.Fact_Akreditasi (sk_waktu);

CREATE NONCLUSTERED INDEX IX_Fact_Akreditasi_sk_prodi
ON dbo.Fact_Akreditasi (sk_prodi);
GO


------------------------------------------------------------
-- Index untuk Foreign Keys pada Fact_Akademik
------------------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Fact_Akademik_sk_waktu
ON dbo.Fact_Akademik (sk_waktu);

CREATE NONCLUSTERED INDEX IX_Fact_Akademik_sk_prodi
ON dbo.Fact_Akademik (sk_prodi);
GO

------------------------------------------------------------
-- Index untuk Foreign Keys pada Fact_Dosen
------------------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Fact_Dosen_sk_waktu
ON dbo.Fact_Dosen (sk_waktu);

CREATE NONCLUSTERED INDEX IX_Fact_Dosen_sk_prodi
ON dbo.Fact_Dosen (sk_prodi);

CREATE NONCLUSTERED INDEX IX_Fact_Dosen_sk_dosen
ON dbo.Fact_Dosen (sk_dosen);
GO


------------------------------------------------------------
-- Covering index untuk common queries (Prestasi per Prodi per Waktu)
------------------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Covering_Prestasi_Prodi_Waktu
ON dbo.Fact_Prestasi (sk_waktu, sk_prodi)
INCLUDE (jumlah_prestasi);
GO

------------------------------------------------------------
-- Covering index untuk laporan Anggaran per Prodi per Tahun
------------------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Covering_Anggaran_Prodi_Waktu
ON dbo.Fact_Anggaran (sk_waktu, sk_prodi)
INCLUDE (total_anggaran);
GO

------------------------------------------------------------
-- Covering index untuk laporan Akreditasi per Prodi per Tahun
------------------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Covering_Akreditasi_Prodi_Waktu
ON dbo.Fact_Akreditasi (sk_waktu, sk_prodi)
INCLUDE (jumlah_akreditasi);
GO

------------------------------------------------------------
-- Covering index untuk laporan Rasio Dosen per Prodi per Tahun
------------------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Covering_Dosen_Prodi_Waktu
ON dbo.Fact_Dosen (sk_waktu, sk_prodi)
INCLUDE (jumlah_dosen, jumlah_mahasiswa, rasio_dosen_mahasiswa);
GO

-- Columnstore index untuk analisis prestasi mahasiswa
CREATE NONCLUSTERED COLUMNSTORE INDEX CS_Fact_Prestasi
ON dbo.Fact_Prestasi
(
    sk_waktu,
    sk_prodi,
    sk_mahasiswa,
    jumlah_prestasi
);
GO

-- Columnstore index untuk analisis anggaran per tahun/prodi
CREATE NONCLUSTERED COLUMNSTORE INDEX CS_Fact_Anggaran
ON dbo.Fact_Anggaran
(
    sk_waktu,
    sk_prodi,
    total_anggaran
);
GO

-- Columnstore index untuk analisis kualitas akreditasi setiap prodi
CREATE NONCLUSTERED COLUMNSTORE INDEX CS_Fact_Akreditasi
ON dbo.Fact_Akreditasi
(
    sk_waktu,
    sk_prodi,
    jumlah_akreditasi
);
GO

-- Columnstore index untuk analisis akademik mahasiswa per waktu
CREATE NONCLUSTERED COLUMNSTORE INDEX CS_Fact_Akademik
ON dbo.Fact_Akademik
(
    sk_waktu,
    sk_prodi,
    jumlah_mahasiswa_baru,
    rata_rata_ipk
);
GO

-- Columnstore index untuk analisis rasio dosen_mahasiswa per waktu
CREATE NONCLUSTERED COLUMNSTORE INDEX CS_Fact_Dosen
ON dbo.Fact_Dosen
(
    sk_waktu,
    sk_prodi,
    jumlah_dosen,
    jumlah_mahasiswa,
    rasio_dosen_mahasiswa
);
GO