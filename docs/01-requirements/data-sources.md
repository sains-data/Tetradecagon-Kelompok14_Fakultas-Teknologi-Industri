## Step 2: Data Source Identification

**Tujuan:** Mengidentifikasi dan menganalisis sumber data yang tersedia

**Aktivitas:**

### Identifikasi Sumber Data

* **Manual data entry**
    * Daftar program studi
    * Dokumen akreditasi
    * Prestasi mahasiswa
    * Data anggaran penelitian
    * Data dosen
* **File Excel/CSV**
    * Data mahasiswa (Angkatan, IPK)

### Data Source Analysis

| Data Source | Type | Volume | Update Frequency |
| :--- | :--- | :--- | :--- |
| Daftar program studi | Website FTI | 21 rows | Sporadis |
| Dokumen akreditasi | Website FTI | 22 rows | 5 tahun - 8 tahun |
| Data anggaran penelitian | Website FTI | 22 rows | Tahunan |
| Data dosen | CSV/Excel | 350 rows | Tahunan |
| Jumlah mahasiswa baru per tahun | CSV/Excel | 13k rows | Tahunan |
| Rata-rata IPK per program studi | CSV/Excel | 21 rows | Tahunan |

### Data Profiling

* **Analisis distribusi data**
* **Identifikasi null values dan outliers**
    * Potensi nilai Null pada data prestasi, data keuangan, akreditasi.
    * IPK > 4.0 atau IPK < 0.0
    * Mahasiswa baru > 500 orang
* **Deteksi duplikasi**
    * Potensi NIM ganda, akreditasi yang berbeda pada tahun yang sama.
* **Konsistensi format data**
    * Format standar YYYY-MM-DD
    * Format numerik yang benar (IPK : float , Jumlah mahasiswa : Integer)

---