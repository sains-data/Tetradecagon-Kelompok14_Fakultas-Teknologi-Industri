CREATE SCHEMA stg;
GO

CREATE TABLE stg.Mahasiswa (
    source_file VARCHAR(255),
    nim VARCHAR(20),
    nama_mahasiswa VARCHAR(200),
    jenis_kelamin CHAR(1),
    angkatan INT,
    status VARCHAR(20),
    kode_prodi VARCHAR(20),
    extract_ts DATETIME DEFAULT GETDATE(),
    row_hash BINARY(16)
);
GO

CREATE TABLE stg.Prestasi (
    source_file VARCHAR(255),
    id_prestasi VARCHAR(50),
    nim VARCHAR(20),
    nama_prestasi VARCHAR(200),
    jenis_prestasi VARCHAR(50),
    tingkat VARCHAR(50),
    penyelenggara VARCHAR(150),
    tanggal_prestasi DATE,
    kode_prodi VARCHAR(20),
    extract_ts DATETIME DEFAULT GETDATE(),
    row_hash BINARY(16)
);
GO

CREATE TABLE stg.Anggaran (
    source_file VARCHAR(255),
    id_anggaran VARCHAR(50),
    kode_prodi VARCHAR(20),
    jenis_anggaran VARCHAR(100),
    total_anggaran DECIMAL(18,2),
    tahun INT,
    extract_ts DATETIME DEFAULT GETDATE(),
    row_hash BINARY(16)
);
GO

CREATE TABLE stg.Akreditasi (
    source_file VARCHAR(255),
    id_akreditasi VARCHAR(50),
    kode_prodi VARCHAR(20),
    status_akreditasi VARCHAR(50),
    nilai_akreditasi DECIMAL(3,2),
    lembaga VARCHAR(100),
    tahun INT,
    extract_ts DATETIME DEFAULT GETDATE(),
    row_hash BINARY(16)
);
GO

CREATE TABLE stg.ProgramStudi (
    source_file VARCHAR(255),
    id_prodi VARCHAR(20),
    nama_prodi VARCHAR(200),
    jenjang VARCHAR(20),
    fakultas VARCHAR(100),
    extract_ts DATETIME DEFAULT GETDATE(),
    row_hash BINARY(16)
);
GO

CREATE TABLE stg.Waktu (
    source_file VARCHAR(255),
    tanggal DATE,
    tahun INT,
    semester VARCHAR(10),
    bulan INT,
    extract_ts DATETIME DEFAULT GETDATE(),
    row_hash BINARY(16)
);
GO