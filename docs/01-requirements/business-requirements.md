# FAKULTAS TEKNOLOGI INDUSTRI
## Tugas Besar
### Pergudangan Data

**Kelompok Ke - 14**

Nama Anggota Kelompok:
* Andre Hadiman Rotua Parhusia (122450108)
* Nabyla Sharfina (123450008)
* Arini Puteri Elandra (123450069)
* Muhammad Fadil Alfaizi (123450115)


## PROGRAM STUDI SAINS DATA
### FAKULTAS SAINS
## INSTITUT TEKNOLOGI SUMATERA
### 2025

---

## Step 1: Business Requirements Analysis

**Tujuan:** Memahami kebutuhan bisnis dan analitik unit kerja

**Aktivitas:**

### Identifikasi Stakeholders

**Pengguna Utama Data Mart**

| Peran | Jabatan / Unit | Kebutuhan Utama |
| :--- | :--- | :--- |
| Pimpinan Fakultas | Dekan & Wakil Dekan (FTI) | "Melihat performa keseluruhan fakultas: jumlah mahasiswa aktif, rasio dosen-mahasiswa, tingkat kelulusan, produktivitas dosen, kinerja akademik, dan efektivitas anggaran." |
| Koordinator Program Studi | Ketua Program Studi | "Menggunakan data akademik per prodi (mahasiswa aktif, IPK rata-rata, tingkat kelulusan, capaian penelitian dosen prodi) untuk analisis perkembangan jumlah mahasiswa, IPK, serta efektivitas kegiatan akademik di tingkat program studi." |
| Staf Akademik dan Keuangan | Dosen Tetap & Tidak Tetap | "Mengelola data harian terkait aktivitas akademik, administrasi keuangan, dan pelaporan rutin ke fakultas atau universitas." |

### Identifikasi Decision Makers

* **Dekan FTI:** Dekan FTI berperan sebagai pengambil keputusan tertinggi di tingkat fakultas. Dalam konteks pemanfaatan OLAP untuk analisis data, Dekan menggunakan informasi yang tersedia untuk melihat gambaran umum performa fakultas, seperti tren capaian akademik, efisiensi anggaran, serta perkembangan sarana dan prasarana. Data tersebut menjadi dasar dalam menetapkan arah kebijakan dan strategi jangka panjang untuk meningkatkan mutu pendidikan, penelitian, dan layanan akademik secara keseluruhan.
* **Wakil Dekan Bidang Akademik & Kemahasiswaan:** Wakil Dekan Bidang Akademik dan Kemahasiswaan memanfaatkan hasil analisis OLAP untuk menilai kualitas proses belajar mengajar, kinerja dosen, serta perkembangan prestasi mahasiswa. Informasi seperti IPK rata-rata, tingkat kelulusan, capaian kompetisi mahasiswa, dan evaluasi pembelajaran digunakan untuk melakukan pembinaan akademik dan meningkatkan efektivitas program kemahasiswaan. Analisis ini membantu menentukan intervensi yang diperlukan agar standar akademik tetap terpenuhi.
* **Wakil Dekan Bidang Keuangan & Sarana Prasarana:** Wakil Dekan Bidang Keuangan dan Sarana Prasarana menggunakan OLAP untuk memonitor alokasi serta realisasi anggaran fakultas. Data mengenai penggunaan dana operasional, pengembangan fasilitas, hingga kebutuhan laboratorium dianalisis untuk memastikan pengelolaan keuangan berjalan efisien. Informasi ini menjadi dasar dalam menyusun prioritas pengadaan fasilitas dan memastikan seluruh sarana mendukung kegiatan akademik secara optimal.
* **Ketua Program Studi:** Ketua Program Studi memanfaatkan analisis OLAP untuk memahami capaian akademik mahasiswa dan kinerja program studi secara keseluruhan. Data seperti jumlah mahasiswa aktif, tingkat kelulusan per semester, distribusi nilai, hingga evaluasi mata kuliah membantu Kaprodi menentukan strategi akademik yang lebih tepat. Informasi ini juga digunakan untuk merancang perbaikan kurikulum, meningkatkan kualitas pengajaran, serta memastikan target program studi tercapai.

### Analisis Proses Bisnis

**Proses Bisnis Utama Unit Kerja**

1.  **Manajemen Akademik**
    * Pendaftaran dan aktivitas akademik mahasiswa.
    * Rata-rata nilai IPK perangkatan.
    * Pengelolaan data prestasi mahasiswa.
2.  **Manajemen Keuangan Fakultas**
    * Pengelolaan anggaran per program studi.
    * Pemantauan pengeluaran dan pendapatan fakultas.
3.  **Evaluasi Kinerja Akademik**
    * Analisis performa akademik mahasiswa per program studi.
    * Penilaian efektivitas pengajaran dan hasil belajar.
    * Evaluasi prestasi dan produktivitas akademik.

**Identifikasi Key Performance Indicators (KPI)**

| Proses Bisnis | KPI | Frekuensi Pemantauan |
| :--- | :--- | :--- |
| Manajemen Akademik Mahasiswa & Dosen | Jumlah Mahasiswa Aktif per Program Studi | Bulanan / Semester |
| | IPK Rata-rata per Program Studi pada Masa TPB | Semester |
| Manajemen Kegiatan Mahasiswa | Jumlah Prestasi Mahasiswa | Tahunan |
| Manajemen Keuangan & Anggaran Fakultas | Rata-rata Pengeluaran per Program Studi | Bulanan |
| Evaluasi Kinerja & Akreditasi Fakultas | Indeks Kinerja Fakultas | Tahunan |

* **Jumlah Mahasiswa Aktif per Program Studi**
    Digunakan untuk memantau kondisi populasi mahasiswa di setiap program studi, memastikan ketersediaan kapasitas kelas, serta menilai pertumbuhan atau penurunan jumlah mahasiswa setiap periode pemantauan.
* **IPK Rata-rata per Program Studi pada Masa TPB**
    Indikator utama kualitas capaian belajar mahasiswa, digunakan untuk mengevaluasi efektivitas proses pembelajaran, kinerja dosen, serta mendeteksi adanya masalah akademik pada program studi tertentu.
* **Jumlah Prestasi Mahasiswa**
    Total capaian mahasiswa dalam bidang akademik maupun non-akademik, digunakan untuk menilai keberhasilan program pembinaan kemahasiswaan serta citra fakultas di tingkat lokal, nasional, maupun internasional.
* **Rata-rata Pengeluaran per Program Studi**
    Mengukur efisiensi penggunaan anggaran di setiap program studi, membantu fakultas memastikan bahwa setiap kegiatan berjalan sesuai perencanaan keuangan dan tidak melebihi batas pengeluaran yang telah ditetapkan.
* **Indeks Kinerja Fakultas (gabungan metrik akademik dan keuangan)**
    Indikator komposit yang menggambarkan performa keseluruhan fakultas dalam aspek akademik, kemahasiswaan, SDM, keuangan, dan pencapaian akreditasi, serta menjadi ukuran utama keberhasilan fakultas secara tahunan.

### Metrik Bisnis

| Proses Bisnis | Metrik Bisnis yang Perlu Dimonitor | Tujuan Pemantauan |
| :--- | :--- | :--- |
| Manajemen Akademik Mahasiswa & Dosen | Jumlah mahasiswa baru per tahun | Mengukur tingkat penerimaan mahasiswa baru dan perencanaan kapasitas |
| | Rata-rata IPK per program studi | Mengukur tingkat kelulusan mahasiswa dan perencanaan evaluasi kinerja |
| Manajemen Kegiatan Mahasiswa | Jumlah prestasi akademik/non-akademik per periode | Mengukur kinerja dan kualitas mahasiswa |
| Manajemen Keuangan & Anggaran Fakultas | Total anggaran penelitian fakultas per tahun | Menentukan kapasitas keuangan tahunan |
| | Rata-rata pengeluaran per program studi untuk penelitian | Menilai distribusi dana antar prodi dan efisiensinya. |
| Evaluasi Kinerja & Akreditasi Fakultas | Akreditasi prodi | Mengukur keberhasilan pengelolaan akademik dan kualitas program studi |

* **Jumlah mahasiswa baru per tahun**
    Digunakan untuk memantau jumlah pendaftar dan mahasiswa yang diterima pada setiap tahun akademik, sehingga fakultas dapat merencanakan kapasitas kelas, kebutuhan dosen, serta mengantisipasi tren penurunan atau peningkatan jumlah mahasiswa.
* **Rata-rata IPK per program studi pada Masa TPB**
    Indikator capaian akademik di masing-masing program studi dan digunakan untuk mengevaluasi kualitas proses belajar, menentukan kebutuhan peningkatan kurikulum, serta mendeteksi area akademik yang memerlukan intervensi.
* **Jumlah prestasi akademik/non-akademik per periode**
    Mencakup penghargaan mahasiswa dalam lomba, kompetisi, maupun kegiatan organisasi, digunakan untuk menilai keberhasilan pembinaan kemahasiswaan dan peningkatan reputasi fakultas.
* **Total anggaran penelitian fakultas per tahun**
    Digunakan untuk memonitor alokasi dana penelitian yang diberikan kepada dosen dan mahasiswa, serta memastikan fakultas dapat menjalankan program penelitian sesuai target tahunan.
* **Rata-rata pengeluaran per program studi untuk penelitian**
    Digunakan untuk mengevaluasi distribusi anggaran antar program studi, memastikan penggunaan dana berjalan efektif, dan menilai apakah kebutuhan penelitian pada setiap program studi telah terpenuhi.
* **Akreditasi prodi**
    Menjadi ukuran kualitas penyelenggaraan akademik di setiap program studi, memonitor keberhasilan pemenuhan standar nasional pendidikan, serta membantu fakultas menentukan strategi peningkatan mutu.

### Kebutuhan Analitik

**Daftar pertanyaan bisnis yang perlu dijawab**

* Bagaimana tren jumlah mahasiswa aktif dalam tiga tahun terakhir?
* Program studi mana yang memiliki IPK rata-rata tertinggi/rendah?
* Bagaimana korelasi antara pengeluaran program studi dengan kinerja akademik mahasiswa?
* Apakah prestasi mahasiswa meningkat dari tahun ke tahun?
* Bagaimana perkembangan indeks kinerja fakultas dalam lima tahun terakhir?

**Jenis Laporan yang Dibutuhkan:**

* **Laporan Harian:**
    * Aktivitas akademik mahasiswa (absensi, nilai masuk sistem).
    * Transaksi keuangan harian (pemasukan dan pengeluaran).
* **Laporan Mingguan:**
    * Rekapitulasi kegiatan akademik dan pengeluaran mingguan.
    * Monitoring prestasi mahasiswa baru.
* **Laporan Bulanan:**
    * Statistik IPK rata-rata per program studi.
    * Laporan keuangan per program studi.
    * Ringkasan indeks kinerja fakultas.
    * Tren jumlah mahasiswa aktif dan prestasi per bulan

**Level Agregasi dan Granularitas Data:**

* **Tingkat Agregasi Tinggi (Summary):**
    * Total mahasiswa aktif fakultas per tahun.
    * IPK rata-rata fakultas per semester.
    * Total pengeluaran fakultas per bulan.
* **Tingkat Granularitas Detail:**
    * Data individu mahasiswa (IPK, prestasi, status akademik).
    * Data pengeluaran per kategori dan program studi.
    * Data kinerja dosen atau kegiatan akademik per mata kuliah.

| Unit Fakultas Teknologi Industri | Analitik Bisnis | Manajemen akademik | Manajemen keuangan fakultas | Evaluasi kinerja akademik | | KPI | Jumlah Mahasiswa Aktif per Program Studi | IPK Rata-rata per Program Studi pada Masa TPB | Jumlah Prestasi Mahasiswa | Rata-rata Pengeluaran Per Program Studi | Indeks Kinerja Fakultas |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |

---

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

## Step 4: Data Modeling - Dimensional Model

*Tujuan:* Mengkonversi model konseptual ke dimensional model untuk data warehouse.

*Aktivitas:*

### Identifikasi Fact Tables

* *Fact_Akademik,* mendukung metrik: (Jumlah mahasiswa per tahun, rata-rata IPK per prodi).
    * Proses bisnis: Pencatatan data akademik per program studi per periode.
    * Grain: 1 baris = data akademik untuk 1 prodi pada 1 tahun ajaran. Measures: jumlah_mahasiswa_baru, rata_rata_ipk
* *Fact_Dosen,* mendukung metrik: (Rasio dosen terhadap mahasiswa per prodi).
    * Proses bisnis: Mengukur beban dosen per program studi per periode.
    * Grain: 1 baris = data staf dosen untuk 1 prodi pada 1 tahun. Measures: jumlah_dosen, jumlah_mahasiswa, rasio_dosen_mahasiswa.
* *Fact_Prestasi,* mendukung metrik: (Jumlah prestasi mahasiswa akademik/non-akademik per periode).
    * Proses bisnis: Pencatatan prestasi mahasiswa.
    * Grain: 1 baris = 1 prestasi mahasiswa pada 1 waktu. Measures: jumlah_prestasi.
* *Fact_Anggaran,* mendukung metrik: (Total anggaran penelitian fakultas per tahun, Rata-rata pengeluaran per prodi).
    * Proses bisnis: Pencatatan anggaran dan dana penelitian.
    * Grain: 1 baris = jumlah anggaran untuk 1 prodi pada 1 periode. Measures: total_anggaran, total_pengeluaran.
* *Fact_Akreditasi,* mendukung metrik: (Status akreditasi prodi).
    * Proses bisnis: Pencatatan hasil akreditasi program studi.
    * Grain: 1 baris = 1 hasil akreditasi prodi pada 1 periode. Measures: jumlah_akreditasi, nilai_akreditasi.

*Klasifikasi additivity (additive, semi-additive, non-additive)*

| Fact | Measures | Additivity | Keterangan |
| :--- | :--- | :--- | :--- |
| Fact_Akademik | jumlah_mahasiswa_baru | Additive | Bisa dijumlahkan across prodi/waktu (kalau periodenya tidak overlap). |
| Fact_Akademik | rata_rata_ipk | Non-Additive | Rata-rata tidak bisa di-sum. |
| Fact_Dosen | jumlah_dosen | Additive | Bisa dijumlahkan antar prodi. |
| Fact_Dosen | rasio_dosen_mahasiswa | Non-Additive | Rasio tidak bisa di-sum. |
| Fact_Prestasi | jumlah_prestasi | Additive | Prestasi dapat dihitung per prodi/waktu. |
| Fact_Anggaran | total_anggaran | Semi-additive | "Tidak dijumlahkan antar tahun, tetapi bisa antar prodi." |
| Fact_Akreditasi | jumlah_akreditasi | Additive | Menghitung jumlah perubahan akreditasi. |

### Identifikasi Dimension Tables

*Dimension yang mendukung analisis (Who, What, Where, When, Why, How)*

* *Who*
    * *Dim _Mahasiswa*: digunakan untuk mengetahui siapa mahasiswa yang terkait dengan prestasi atau data lain.
    * *Dim_Dosen*: digunakan untuk mengetahui rasio dosen dan mahasiswa.
* *What*
    * *Dim_Prestasi*: digunakan untuk menjelaskan prestasi apa yang diraih oleh mahasiswa.
* *Where*
    * *Dim_ProgramStudi*: digunakan untuk menjelaskan program studi mana yang sedang dianalisis.
* *When*
    * *Dim_Waktu*: digunakan untuk menjelaskan kapan suatu prestasi, anggaran atau akreditasi terjadi.
* *Why*
    * *Dim_Anggaran*: digunakan untuk menjelaskan anggaran apa yang sedang dianalisis.
* *How*
    * *Dim_Akreditasi*: digunakan untuk menjelaskan status akreditasi prodi sebagai indikator kualitas institusi.

*Atribut deskriptif untuk filtering dan grouping*

* *Dim_Mahasiswa*
    * Nama_mahasiswa
    * Jenis_kelamin
    * Angkatan
    * Status
    * Id_prodi
    * *Filtering*: per jenis kelamin, per angkatan, per status mahasiswa.
    * *Grouping*: jumlah mahasiswa per prodi, per angkatan.
* *Dim_Prestasi*
    * Nama_prestasi
    * Jenis_prestasi
    * Tingkat
    * Penyelenggara
    * *Filtering*: prestasi tingkat nasional/internasional, jenis lomba.
    * *Grouping*: prestasi berdasarkan jenis atau tingkat.
* *Dim_ProgramStudi*
    * Nama_prodi
    * Jenjang
    * Fakultas
    * *Filtering*: Prodi tertentu, Jenjang S1, Fakultas.
    * *Grouping*: total prestasi per fakultas, total anggaran per prodi.
* *Dim_Waktu*
    * Tahun
    * Semester
    * Bulan
    * Tanggal
    * *Filtering*: per tahun, per semester.
    * *Grouping*: total prestasi per tahun, total anggaran per bulan.
* *Dim_Anggaran*
    * Keterangan
    * *Filtering*: jenis anggaran tertentu.
    * *Grouping*: penggunaan anggaran berdasarkan kategori.
* *Dim_Dosen*
    * Status_kepegawaian
    * Jabatan_fungsional
    * Nama_dosen / NIDN
    * *Filtering* : memilih dosen berdasarkan status kepegawaian (Tetap, Kontrak), jabatan fungsional (Asisten Ahli, Lektor, dst.), atau prodi tertentu.
    * *Grouping* : mengelompokkan dosen per jabatan fungsional, per status kepegawaian, atau per program studi untuk analisis beban mengajar, rasio dosen–mahasiswa, atau distribusi dosen.
* *Dim_Akreditasi*
    * Status_akreditasi
    * Nilai_akreditasi
    * Lembaga
    * *Filtering*: prodi dengan akreditasi tertentu.
    * *Grouping*: status akreditasi per fakultas atau per tahun melalui fact.

*Hierarki dalam dimensi (untuk drill-down/roll-up)*

* *Dim_Waktu*
    * Drill-down : Tahun → Semester tertentu → Bulan tertentu → Aktivitas pada tanggal tertentu.
* *Dim_ProgramStudi*
    * Drill-down : Fakultas → Prodi → (menganalisis prestasi/anggaran untuk prodi tersebut)
* *Dim_Prestasi*
    * Jenis (Akademik/Non-Akademik) → Tingkat (Lokal/Nasional/Internasional) → Nama Lomba.
* *Dim_Mahasiswa*
    * Angkatan → Status (aktif/cuti) → individu mahasiswa.
* *Dim_Anggaran*
    * Tidak memiliki hirarki yang jelas, tetapi bisa dimodelkan:
    * Kategori Anggaran → Jenis Anggaran (keterangan).
* Dim_Dosen
    * Status Kepegawaian → Jabatan Fungsional → Dosen (NIDN)
* *Dim_Akreditasi*
    * Drill-down : Lembaga (BAN-PT) → Status (Unggul/A/B) → Nilai.

### Desain Star/Snowflake Schema


### Penentuan Surrogate Keys

* *Dim_ProgramStudi*
    * Natural key : id_prodi
    * Surrogate key : sk_prodi
* *Dim_Mahasiswa*
    * Natural Key : NIM
    * Surrogate Key : sk_mahasiswa
* *Dim_Dosen*
    * Natural Key : NIDN
    * Surrogate Key : sk_dosen
* *Dim_Waktu*
    * Natural Key : id_waktu
    * Surrogate Key : sk_waktu
* *Dim_Prestasi*
    * Natural Key : id_Prestasi
    * Surrogate Key : sk_prestasi
* *Dim_Anggaran*
    * Natural Key : id_anggaran
    * Surrogate Key : sk_anggaran
* *Dim_Akreditasi*
    * Natural key: id_akreditasi
    * Surrogate key: sk_akreditasi

* *Fact_Prestasi*
    * sk_prestasi
    * sk_mahasiswa
    * sk_prodi
    * sk_waktu
* *Fact_Anggaran*
    * sk_anggaran
    * sk_prodi
    * sk_waktu
* *Fact_Akreditasi*
    * sk_akreditasi
    * sk_prodi
    * sk_waktu
* *Fact_Akademik*
    * sk_akademik
    * sk_mahasiswa
    * sk_matakuliah
    * sk_prodi
    * sk_waktu
 * *Fact_Dosen*
    * sk_dosen
    * sk_prodi
    * sk_waktu
    * sk_matakuliah

---
