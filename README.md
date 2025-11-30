# 🚀 Data Mart Fakultas Teknologi Industri (FTI) - Institut Teknologi Sumatera

## 🎯 Project Overview
Data mart Fakultas Teknologi Industri (FTI) dibangun untuk mengintegrasikan berbagai sumber data akademik dan administratif yang sebelumnya tersebar pada banyak file dan sistem terpisah. Dengan mengkonsolidasikan data terkait mahasiswa, dosen, prestasi, akreditasi, dan anggaran ke dalam satu struktur dimensional, data mart ini menyediakan informasi yang lebih terorganisir, akurat, dan mudah diakses untuk keperluan analisis. Proses ini membuat penyusunan laporan, evaluasi rutin, serta monitoring kinerja fakultas menjadi lebih cepat dan konsisten.

Secara bisnis, data mart memberikan nilai strategis bagi pimpinan FTI karena memungkinkan analisis multidimensi seperti tren mahasiswa aktif, perkembangan mutu akademik, hingga efisiensi penggunaan anggaran. Informasi yang tersaji secara lebih komprehensif membantu pimpinan dalam pengambilan keputusan berbasis data, merencanakan strategi pengembangan fakultas, serta memenuhi kebutuhan pelaporan internal maupun eksternal. Dengan demikian, data mart menjadi fondasi penting dalam mendukung transformasi manajemen FTI menuju sistem yang lebih efektif dan data-driven.

## 👥 Team Members (Kelompok Ke-14)
| NIM | Name | Role | Email |
| :--- | :--- | :--- | :--- |
| 123450115 | Muhammad Fadil Alfaizi | Project Lead & Database Designer | muhammad.123450115@student.itera.ac.id |
| 122450108 | Andre Hadiman Rotua Parhusip | ETL Developer | andre.122450108@student.itera.ac.id |
| 123450008 | Nabyla Sharfina | BI Developer | nabyla.123450008@student.itera.ac.id |
| 123450069 | Arini Puteri Elandra | Documentation & QA | arini.123450069@student.itera.ac.id |

## 🏢 Business Domain (Fakultas Teknologi Industri)

### Key Business Processes
Tiga proses bisnis utama FTI yang menjadi fokus Data Mart ini adalah:

1.  **Manajemen Akademik**
    * Pendaftaran dan aktivitas akademik mahasiswa.
    * Pengelolaan rata-rata nilai IPK per angkatan.
    * Pengelolaan data prestasi mahasiswa.
2.  **Manajemen Keuangan Fakultas**
    * Pengelolaan anggaran per program studi.
    * Pemantauan pengeluaran dan pendapatan fakultas.
3.  **Evaluasi Kinerja Akademik**
    * Analisis performa akademik mahasiswa per program studi.
    * Penilaian efektivitas pengajaran dan hasil belajar.
    * Evaluasi prestasi dan produktivitas akademik.

### Stakeholders
| Peran | Jabatan/Unit | Kebutuhan Utama |
| :--- | :--- | :--- |
| **Pimpinan Fakultas** | Dekan & Wakil Dekan (FTI) | Melihat performa keseluruhan fakultas (jumlah mahasiswa aktif, rasio dosen-mahasiswa, tingkat kelulusan, efektivitas anggaran). |
| **Koordinator Program Studi** | Ketua Program Studi | Menggunakan data akademik per prodi untuk analisis perkembangan jumlah mahasiswa dan efektivitas kegiatan akademik. |
| **Staf Akademik dan Keuangan** | Dosen Tetap & Tidak Tetap | Mengelola data harian terkait aktivitas akademik, administrasi keuangan, dan pelaporan rutin. |

### Decision-Making Needs
| Decision Maker | Peran & Jabatan | Kebutuhan Pengambilan Keputusan |
| :--- | :--- | :--- |
| **Dekan FTI** | Pengambil keputusan tertinggi di tingkat fakultas. | Menetapkan arah kebijakan dan strategi jangka panjang untuk meningkatkan mutu pendidikan, penelitian, dan layanan akademik secara keseluruhan. |
| **Wakil Dekan Bidang Akademik & Kemahasiswaan** | Bertanggung jawab atas kualitas proses belajar mengajar dan perkembangan mahasiswa. | Menentukan intervensi yang diperlukan (pembinaan akademik atau program kemahasiswaan) agar standar akademik tetap terpenuhi. |
| **Wakil Dekan Bidang Keuangan & Sarana Prasarana** | Bertanggung jawab memonitor alokasi dan realisasi anggaran. | Menyusun prioritas pengadaan fasilitas dan memastikan seluruh sarana mendukung kegiatan akademik secara optimal, berdasarkan efisiensi pengelolaan keuangan. |
| **Ketua Program Studi** | Bertanggung jawab atas capaian dan kinerja program studi. | Menentukan strategi akademik yang lebih tepat (misalnya perbaikan kurikulum, peningkatan kualitas pengajaran) serta memastikan target program studi tercapai. |

## 📊 Key Performance Indicators (KPIs)
| Proses Bisnis | KPI | Frekuensi Pemantauan |
| :--- | :--- | :--- |
| Manajemen Akademik Mahasiswa & Dosen | Jumlah Mahasiswa Aktif per Program Studi | Bulanan / Semester |
| Manajemen Akademik Mahasiswa & Dosen | IPK Rata-rata per Program Studi pada Masa TPB | Semester |
| Manajemen Kegiatan Mahasiswa | Jumlah Prestasi Mahasiswa | Tahunan |
| Manajemen Keuangan & Anggaran Fakultas | Rata-rata Pengeluaran per Program Studi | Bulanan |
| Evaluasi Kinerja & Akreditasi Fakultas | Indeks Kinerja Fakultas | Tahunan |

## ⚙️ Architecture & Data Model

### Architecture Stack
* **Approach**: Kimball Dimensional Modeling
* **Database**: SQL Server 2019 on Azure VM
* **ETL**: SQL Server Integration Services (SSIS)
* **Visualization**: Power BI Desktop
* **Version Control**: Git

### Data Model
* **Fact Tables (Tabel Fakta)**
    * `Fact_Akademik` (Jumlah mahasiswa baru, rata-rata IPK)
    * `Fact_Dosen` (Rasio dosen mahasiswa)
    * `Fact_Prestasi` (Jumlah prestasi)
    * `Fact_Anggaran` (Total anggaran, total pengeluaran)
    * `Fact_Akreditasi` (Status akreditasi)

* **Dimension Tables (Tabel Dimensi)**
    * `Dim_Mahasiswa` (Who)
    * `Dim_ProgramStudi` (Where)
    * `Dim_Waktu` (When)
    * `Dim_Prestasi` (What)
    * `Dim_Anggaran` (Why)
    * `Dim_Akreditasi` (How)

### Folder Structure
Semua dokumentasi, skrip SQL, dan paket ETL diorganisasi dalam struktur folder berikut:
FTI-DataMart
│
├── docs
│   ├── Laporan_Misi2.pdf
│   ├── Dimensional_Model.png
│   ├── Physical_Design.png
│   ├── ETL_Architecture.png
│   └── Data_Quality_Checks_Overview.md
│
├── sql
│   ├── database
│   │   └── 01_Create_Database.sql
│   ├── dimensions
│   │   └── 02_Create_Dimension_Tables.sql
│   ├── facts
│   │   └── 03_Create_Fact_Tables.sql
│   ├── indexing
│   │   └── 04_Indexing_Strategy.sql
│   ├── columnstore
│   │   └── 05_Columnstore_Indexes.sql
│   ├── partitioning
│   │   └── 06_Partitioning_Strategy.sql
│   ├── staging
│   │   └── 07_Staging_Tables.sql
│   ├── etl_merge
│   │   └── 08_ETL_Merge_Scripts.sql
│   ├── etl_facts
│   │   └── 09_ETL_Load_Facts.sql
│   └── quality
│       └── 10_Data_Quality_Checks.sql
│
├── etl
│   ├── ssis
│   │   ├── Load_Dimension.dtsx
│   │   ├── Load_Facts.dtsx
│   │   └── Master_ETL.dtsx
│   ├── mapping_document.xlsx
│   └── dataflow_design.png
│
├── dashboards
│   └── PowerBI_FTI.pbix
│
└── README.md

## Physical Data Model
Desain data mart menggunakan pendekatan **dimensional modeling (Kimball)** dengan dua komponen utama:
- **Tabel Dimensi**: berisi informasi referensial seperti mahasiswa, dosen, program studi, waktu, jenis prestasi, dan kategori anggaran.
- **Tabel Fakta**: menyimpan data terukur seperti jumlah mahasiswa aktif, total anggaran, jumlah prestasi, rasio dosen-mahasiswa, dan status akreditasi.

Setiap tabel dimensi menggunakan **surrogate key**, sementara tabel fakta berisi **measures** dan foreign key ke dimensi terkait.

## Indexing Strategy
Repository ini menyertakan skrip indexing untuk meningkatkan performa query, khususnya saat digunakan dalam dashboard analitik:
- **Clustered index** pada tabel fakta untuk mempercepat scan dan agregasi.
- **Nonclustered index** pada foreign key untuk mendukung join antar dimensi–fakta.
- **Columnstore index** pada fact tables guna mempercepat analisis data berukuran besar.

## Partitioning Strategy
Beberapa tabel fakta dipartisi berdasarkan **tahun akademik**, sehingga:
- Query yang menargetkan tahun tertentu menjadi lebih cepat (partition pruning).
- Proses ETL lebih efisien karena dapat memuat data per partisi.
- Penyimpanan data multi-tahun menjadi lebih terstruktur dan scalable.

Partitioning menggunakan boundary tahun pada kolom waktu (`sk_waktu`).

## ETL & Data Quality Overview

### ETL Pipeline
ETL dirancang menggunakan tiga lapisan:
1. **Staging (stg)** – data mentah hasil extract.
2. **Integration (int)** – proses standarisasi, cleansing, deduplication, dan mapping.
3. **Data Warehouse (dbo)** – load akhir ke tabel fakta dan dimensi.

Pipeline ETL diimplementasikan dengan **SSIS** dan didukung skrip `MERGE` SQL.

### Data Quality Checks
Validasi kualitas data dilakukan pada tahapan integrasi, mencakup:
- **Completeness check**: memverifikasi data wajib seperti NIM, nama, kode prodi.
- **Duplicate detection**: mengecek duplikasi pada mahasiswa, prestasi, atau anggaran.
- **Referential integrity check**: memastikan fakta terhubung dengan dimensi valid.
- **Range & format validation**: misalnya nilai tidak boleh negatif, kategori sesuai standar.

Dokumentasi DQ terdapat pada folder `/docs`.
