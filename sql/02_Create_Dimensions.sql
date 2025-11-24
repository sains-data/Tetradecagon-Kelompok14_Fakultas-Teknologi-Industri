-- Dimension Table: Dim_ProgramStudi
CREATE TABLE dbo.Dim_ProgramStudi (
   sk_prodi INT IDENTITY(1,1) PRIMARY KEY,
   id_prodi INT NOT NULL UNIQUE,
   nama_prodi VARCHAR(150) NOT NULL,
   jenjang VARCHAR(10) NOT NULL,
   fakultas VARCHAR(100) NOT NULL,


   created_date DATETIME DEFAULT GETDATE(),
   updated_date DATETIME DEFAULT GETDATE()
);
GO

-- Dimension Table: Dim_Mahasiswa
CREATE TABLE dbo.Dim_Mahasiswa (
   sk_mahasiswa INT IDENTITY(1,1) PRIMARY KEY,
   nim VARCHAR(20) NOT NULL UNIQUE,
   nama_mahasiswa VARCHAR(150) NOT NULL,
   jenis_kelamin CHAR(1) CHECK (jenis_kelamin IN ('L','P')),
   angkatan INT NOT NULL,
   status VARCHAR(50),


   sk_prodi INT NOT NULL,
   FOREIGN KEY (sk_prodi) REFERENCES dbo.Dim_ProgramStudi(sk_prodi),


   created_date DATETIME DEFAULT GETDATE(),
   updated_date DATETIME DEFAULT GETDATE()
);
GO






-- Dimension Table: Dim_Dosen
CREATE TABLE dbo.Dim_Dosen (
   sk_dosen INT IDENTITY(1,1) PRIMARY KEY,
   nidn VARCHAR(20) NOT NULL UNIQUE,
   nama_dosen VARCHAR(150) NOT NULL,
   jabatan_fungsional VARCHAR(150),
   status_kepegawaian VARCHAR(50),


   sk_prodi INT NOT NULL,
   FOREIGN KEY (sk_prodi) REFERENCES dbo.Dim_ProgramStudi(sk_prodi),


   created_date DATETIME DEFAULT GETDATE(),
   updated_date DATETIME DEFAULT GETDATE()
);
GO






-- Dimension Table: Dim_Waktu
CREATE TABLE dbo.Dim_Waktu (
   sk_waktu INT PRIMARY KEY,
   tanggal DATE NOT NULL,
   tahun INT NOT NULL,
   semester VARCHAR(10) NOT NULL,
   bulan INT NOT NULL,
   nama_bulan VARCHAR(10) NOT NULL
);
GO




-- Dimension Table: Dim_Prestasi
CREATE TABLE dbo.Dim_Prestasi (
   sk_prestasi INT IDENTITY(1,1) PRIMARY KEY,
   id_prestasi VARCHAR(20) NOT NULL UNIQUE,
   nama_prestasi VARCHAR(100),
   jenis_prestasi VARCHAR(30),
   tingkat VARCHAR(30),
   penyelenggara VARCHAR(100),


   created_date DATETIME DEFAULT GETDATE()
);
GO




-- Dimension Table: Dim_Anggaran
CREATE TABLE dbo.Dim_Anggaran (
   sk_anggaran INT IDENTITY(1,1) PRIMARY KEY,
   id_anggaran VARCHAR(20) NOT NULL UNIQUE,
   kategori VARCHAR(100),
   keterangan VARCHAR(200),


   created_date DATETIME DEFAULT GETDATE()
);
GO




-- Dim_Akreditasi
CREATE TABLE dbo.Dim_Akreditasi (
   sk_akreditasi INT IDENTITY(1,1) PRIMARY KEY,
   id_akreditasi VARCHAR(20) NOT NULL UNIQUE,
   status_akreditasi VARCHAR(20),
   nilai_akreditasi DECIMAL(3,2),
   lembaga VARCHAR(20),


   created_date DATETIME DEFAULT GETDATE()
);
GO
