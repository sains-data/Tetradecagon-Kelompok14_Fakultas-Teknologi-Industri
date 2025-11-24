-- ===========================================
-- Partitioning by Academic Year ranges
-- ===========================================

CREATE PARTITION FUNCTION PF_AcademicYear (INT)
AS RANGE RIGHT FOR VALUES
(
    20200101,
    20210101,
    20220101,
    20230101,
    20240101,
    20250101
);
GO

CREATE PARTITION SCHEME PS_AcademicYear
AS PARTITION PF_AcademicYear
ALL TO ([PRIMARY]);
GO

CREATE TABLE dbo.Fact_Prestasi_Partitioned
(
    sk_prestasi INT NOT NULL,
    sk_mahasiswa INT NOT NULL,
    sk_prodi INT NOT NULL,
    sk_waktu INT NOT NULL,

    created_date DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (sk_prestasi) REFERENCES dbo.Dim_Prestasi(sk_prestasi),
    FOREIGN KEY (sk_mahasiswa) REFERENCES dbo.Dim_Mahasiswa(sk_mahasiswa),
    FOREIGN KEY (sk_prodi) REFERENCES dbo.Dim_ProgramStudi(sk_prodi),
    FOREIGN KEY (sk_waktu) REFERENCES dbo.Dim_Waktu(sk_waktu)
)
ON PS_AcademicYear(sk_waktu);
GO

CREATE TABLE dbo.Fact_Anggaran_Partitioned
(
    sk_anggaran INT NOT NULL,
    sk_prodi INT NOT NULL,
    sk_waktu INT NOT NULL,

    total_anggaran DECIMAL(18,2),
    created_date DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (sk_anggaran) REFERENCES dbo.Dim_Anggaran(sk_anggaran),
    FOREIGN KEY (sk_prodi) REFERENCES dbo.Dim_ProgramStudi(sk_prodi),
    FOREIGN KEY (sk_waktu) REFERENCES dbo.Dim_Waktu(sk_waktu)
)
ON PS_AcademicYear(sk_waktu);
GO

CREATE TABLE dbo.Fact_Akreditasi_Partitioned
(
    sk_akreditasi INT NOT NULL,
    sk_prodi INT NOT NULL,
    sk_waktu INT NOT NULL,

    created_date DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (sk_akreditasi) REFERENCES dbo.Dim_Akreditasi(sk_akreditasi),
    FOREIGN KEY (sk_prodi) REFERENCES dbo.Dim_ProgramStudi(sk_prodi),
    FOREIGN KEY (sk_waktu) REFERENCES dbo.Dim_Waktu(sk_waktu)
)
ON PS_AcademicYear(sk_waktu);
GO

CREATE TABLE dbo.Fact_Akademik_Partitioned
(
    sk_prodi INT NOT NULL,
    sk_waktu INT NOT NULL,

    jumlah_mahasiswa_baru INT,
    rata_rata_ipk DECIMAL(4,2),
    created_date DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (sk_prodi) REFERENCES dbo.Dim_ProgramStudi(sk_prodi),
    FOREIGN KEY (sk_waktu) REFERENCES dbo.Dim_Waktu(sk_waktu)
)
ON PS_AcademicYear(sk_waktu);
GO

CREATE TABLE dbo.Fact_Dosen_Partitioned
(
    sk_prodi INT NOT NULL,
    sk_waktu INT NOT NULL,

    jumlah_dosen INT,
    jumlah_mahasiswa INT,
    rasio_dosen_mahasiswa DECIMAL(6,3),
    created_date DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (sk_prodi) REFERENCES dbo.Dim_ProgramStudi(sk_prodi),
    FOREIGN KEY (sk_waktu) REFERENCES dbo.Dim_Waktu(sk_waktu)
)
ON PS_AcademicYear(sk_waktu);
GO

