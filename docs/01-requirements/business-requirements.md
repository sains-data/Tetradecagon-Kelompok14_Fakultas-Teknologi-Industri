| CSV/Excel | 21 rows | Tahunan |

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

## Step 3: Conceptual Design - ERD

**Tujuan:** Membuat model konseptual yang merepresentasikan entitas bisnis

**Aktivitas:**

### Identifikasi Entitas

* **Entitas Utama, Atribut untuk Setiap Entitas, Primary Keys dan Foreign Keys**
    * **Program_studi:** id_prodi (PK), nama_prodi, jenjang, fakultas
    * **Mahasiswa:** nim (PK), nama_mahasiswa, jenis kelamin, angkatan, status, id_prodi (FK)
    * **Dosen:** nidn (PK), nama_dosen, jabatan_fungsional, status_kepegawaian, id_prodi (FK)
    * **Prestasi:** id_prestasi (PK), nama_prestasi, jenis_prestasi, tingkat, penyelenggara, nim (FK), id_waktu (FK), id_prodi (FK)
    * **Anggaran:** id_anggaran (PK), total_anggaran, tahun, id_prodi (FK), id_waktu (FK)
    * **Akreditasi:** id_akreditasi (PK), status_akreditasi, nilai_akreditasi, lembaga, id_prodi (FK), id_waktu (FK)
    * **Waktu:** id_waktu (PK), tahun, semester, bulan, tanggal

### Definisi Relationships

* **One to One, One to Many, Many to Many**
    * Program Studi - Mahasiswa: One-to-Many
    * Program Studi - Dosen: One-to-Many
    * Mahasiswa - Prestasi: One-to-Many
    * Program Studi - Prestasi: One-to-Many
    * Program Studi - Anggaran: One-to-Many
    * Program Studi - Akreditasi: One-to-Many
    * Waktu - Semua Entitas Fakta: One-to-Many

* **Kardinalitas relationships**
    * **Program Studi - Mahasiswa**
        * 1 Program Studi memiliki banyak Mahasiswa
        * 1 Mahasiswa hanya terdaftar pada 1 Program Studi
    * **Program Studi - Dosen**
        * 1 Program Studi memiliki banyak Dosen
        * 1 Dosen hanya terdaftar pada 1 Program Studi
    * **Mahasiswa - Prestasi**
        * 1 Mahasiswa dapat memiliki banyak Prestasi
        * 1 Prestasi hanya dimiliki oleh 1 Mahasiswa
    * **Program Studi - Prestasi**
        * 1 Program Studi dapat memiliki banyak Prestasi mahasiswa
        * 1 Prestasi hanya terkait dengan 1 Program Studi (berdasarkan prodi mahasiswa)
    * **Program Studi - Anggaran**
        * 1 Program Studi dapat memiliki banyak Anggaran (per tahun / periode)
        * 1 Anggaran hanya diberikan kepada 1 Program Studi
    * **Program Studi - Akreditasi**
        * 1 Program Studi dapat memiliki banyak catatan Akreditasi (riwayat akreditasi)
        * 1 Akreditasi hanya berlaku untuk 1 Program Studi
    * **Waktu - Semua Entitas Fakta**
        * 1 Program Studi dapat memiliki banyak catatan Akreditasi (riwayat akreditasi)
        * 1 Akreditasi hanya berlaku untuk 1 Program Studi

* **Optional vs mandatory relationships**
    * **Program Studi - Mahasiswa**
        * Program Studi (mandatory) harus ada sebelum Mahasiswa dibuat
        * Mahasiswa (optional) karena prodi dapat ada tanpa mahasiswa (contoh: prodi baru dibuka)
    * **Mahasiswa - Prestasi**
        * Mahasiswa (mandatory) harus ada terlebih dahulu sebelum prestasi dicatat
        * Prestasi (optional) karena tidak semua mahasiswa memiliki prestasi
    * **Program Studi - Prestasi**
        * Program Studi (mandatory) harus ada
        * Prestasi (optional) karena tidak semua prodi memiliki mahasiswa berprestasi
    * **Program Studi - Anggaran**
        * Program Studi (mandatory) wajib ada
        * Anggaran (optional) karena anggaran dapat bervariasi per periode dan bisa saja belum tersedia
    * **Program Studi - Akreditasi**
        * Program Studi (mandatory)
        * Akreditasi (optional) terutama saat prodi baru berdiri dan belum mendapatkan nilai akreditasi
    * **Waktu - Semua Entitas Fakta**
        * Waktu (mandatory) karena setiap entitas fakta membutuhkan timestamp
        * Fakta (optional) karena tidak semua tanggal memiliki data prestasi/anggaran/akreditasi

### Gambar ERD


---

## Step 4: Logical Design - Dimensional Model