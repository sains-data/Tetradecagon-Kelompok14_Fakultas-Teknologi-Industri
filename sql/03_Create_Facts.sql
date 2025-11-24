-- Fact Table: Fact_Prestasi
CREATE TABLE dbo.Fact_Prestasi (
    sk_prestasi INT NOT NULL,
    sk_mahasiswa INT NOT NULL,
    sk_prodi INT NOT NULL,
    sk_waktu INT NOT NULL,

    created_date DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (sk_prestasi) REFERENCES dbo.Dim_Prestasi(sk_prestasi),
    FOREIGN KEY (sk_mahasiswa) REFERENCES dbo.Dim_Mahasiswa(sk_mahasiswa),
    FOREIGN KEY (sk_prodi) REFERENCES dbo.Dim_ProgramStudi(sk_prodi),
    FOREIGN KEY (sk_waktu) REFERENCES dbo.Dim_Waktu(sk_waktu)
);
GO




-- Fact Table: Fact_Anggaran
CREATE TABLE dbo.Fact_Anggaran (
    sk_anggaran INT NOT NULL,
    sk_prodi INT NOT NULL,
    sk_waktu INT NOT NULL,  -- mapped by tahun only

    total_anggaran DECIMAL(18,2) NOT NULL,

    created_date DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (sk_anggaran) REFERENCES dbo.Dim_Anggaran(sk_anggaran),
    FOREIGN KEY (sk_prodi) REFERENCES dbo.Dim_ProgramStudi(sk_prodi),
    FOREIGN KEY (sk_waktu) REFERENCES dbo.Dim_Waktu(sk_waktu)
);
GO




-- Fact Table: Fact_Akreditasi
CREATE TABLE dbo.Fact_Akreditasi (
    sk_akreditasi INT NOT NULL,
    sk_prodi INT NOT NULL,
    sk_waktu INT NOT NULL,

    created_date DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (sk_akreditasi) REFERENCES dbo.Dim_Akreditasi(sk_akreditasi),
    FOREIGN KEY (sk_prodi) REFERENCES dbo.Dim_ProgramStudi(sk_prodi),
    FOREIGN KEY (sk_waktu) REFERENCES dbo.Dim_Waktu(sk_waktu)
);
GO


-- Fact Table: Fact_Akademik
CREATE TABLE dbo.Fact_Akademik (
    sk_prodi INT NOT NULL,
    sk_waktu INT NOT NULL,

    jumlah_mahasiswa_baru INT,
    rata_rata_ipk DECIMAL(4,2),

    created_date DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (sk_prodi) REFERENCES dbo.Dim_ProgramStudi(sk_prodi),
    FOREIGN KEY (sk_waktu) REFERENCES dbo.Dim_Waktu(sk_waktu)
);
GO


-- Fact Table: Fact_Dosen
CREATE TABLE dbo.Fact_Dosen (
    sk_prodi INT NOT NULL,
    sk_waktu INT NOT NULL,

    jumlah_dosen INT,
    jumlah_mahasiswa INT,
    rasio_dosen_mahasiswa DECIMAL(6,3),

    created_date DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (sk_prodi) REFERENCES dbo.Dim_ProgramStudi(sk_prodi),
    FOREIGN KEY (sk_waktu) REFERENCES dbo.Dim_Waktu(sk_waktu)
);
GO
