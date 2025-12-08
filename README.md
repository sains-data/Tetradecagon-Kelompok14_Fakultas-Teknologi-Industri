# Data Mart Fakultas Teknologi Industri – Institut Teknologi Sumatera

## Project Overview
Data Mart Fakultas Teknologi Industri (FTI) dikembangkan untuk menyediakan platform analitik terintegrasi yang mendukung pengambilan keputusan bagi pimpinan fakultas, ketua program studi, dan unit akademik. Sistem ini memuat data akademik, prestasi mahasiswa, anggaran fakultas, statistik dosen, dan riwayat akreditasi. Tujuan utama dari data mart ini adalah menyediakan laporan dan visualisasi yang konsisten, mudah diakses, dan membantu fakultas dalam melakukan evaluasi serta perencanaan strategis.

## Team Members
| NIM       | Name                         | Role                             | Email |
| --------- | ---------------------------- | -------------------------------- | ----- |
| 122450108 | Andre Hadiman Rotua Parhusip | Project Lead & Database Designer | –     |
| 123450008 | Nabyla Sharfina              | ETL Developer                    | –     |
| 123450069 | Arini Puteri Elandra         | BI Developer                     | –     |
| 123450115 | Muhammad Fadil Alfaizi       | Documentation & QA               | –     |

## Business Domain
Proyek ini difokuskan pada Fakultas Teknologi Industri (FTI), yang terdiri atas beberapa program studi dan unit akademik. Data mart ini mendukung proses pengelolaan akademik, keuangan, prestasi, akreditasi, dan data dosen.

### Key Business Processes
* Pengelolaan akademik mahasiswa
* Pengelolaan anggaran program studi dan fakultas
* Pemantauan prestasi mahasiswa
* Monitoring status dan riwayat akreditasi
* Analisis statistik dosen dan rasio dosen–mahasiswa

### Stakeholders
* Dekan dan Wakil Dekan FTI
* Ketua Program Studi
* Unit Akademik
* Unit Keuangan
* Unit Penjaminan Mutu

### Decision-Making Needs
* Analisis jumlah mahasiswa aktif
* Tren prestasi mahasiswa
* Evaluasi IPK per program studi
* Pengelolaan anggaran dan realisasinya
* Pemantauan perkembangan akreditasi

## Objectives
1. Mengembangkan Data Mart FTI sebagai sumber data terintegrasi.
2. Membangun pipeline ETL terjadwal yang stabil dan dapat diandalkan.
3. Menyediakan dashboard interaktif untuk pimpinan fakultas dan kaprodi.

## Key Performance Indicators (KPIs)
* Jumlah mahasiswa aktif per tahun dan prodi
* IPK rata-rata per program studi
* Jumlah prestasi mahasiswa per tahun
* Total anggaran dan realisasi per prodi
* Status akreditasi program studi

## Architecture
* **Approach**: Kimball Dimensional Modeling
* **Database**: SQL Server 2019 on Azure VM
* **ETL**: SQL Server Integration Services (SSIS) dan Stored Procedure
* **Visualization**: Power BI Desktop
* **Version Control**: GitHub

### Data Model

**Fact Tables:**
* Fact_Akademik – IPK, mahasiswa aktif, mahasiswa baru
* Fact_Prestasi – riwayat prestasi mahasiswa
* Fact_Anggaran – anggaran dan realisasi per prodi
* Fact_Dosen – statistik dosen dan rasio dosen–mahasiswa
* Fact_Akreditasi – riwayat akreditasi

**Dimension Tables:**
* Dim_Waktu
* Dim_ProgramStudi
* Dim_Mahasiswa
* Dim_Dosen
* Dim_Prestasi
* Dim_Anggaran
* Dim_Akreditasi

## Repository Structure
```
README.md
docs/
  01-requirements/
  02-design/
  03-implementation/
sql/
  01_Create_Database.sql
  02_Create_Dimensions.sql
  03_Create_Facts.sql
etl/
  packages/
  scripts/
dashboards/
  PowerBI files
tests/
  test scripts
```

## Getting Started

### Prerequisites
* SQL Server 2019 atau lebih baru
* SQL Server Management Studio (SSMS)
* Power BI Desktop
* Akses Azure VM

### Installation
1. Clone repository:

```
git clone https://github.com/[org]/[repo].git
```

2. Jalankan SQL scripts secara berurutan:
```
sqlcmd -S [server] -d [database] -i sql/01_Create_Database.sql
sqlcmd -S [server] -d [database] -i sql/02_Create_Dimensions.sql
sqlcmd -S [server] -d [database] -i sql/03_Create_Facts.sql
```

3. Deploy SSIS packages atau jalankan ETL Run Script.
4. Buka dashboard Power BI dan refresh sumber data.

## Dashboards
* **Executive Dashboard:** KPIs utama fakultas (IPK, prestasi, anggaran, akreditasi, mahasiswa).
* **Operational Dashboard:** analisis detail per program studi.
* **Custom Reports:** laporan khusus yang dibuat sesuai kebutuhan pimpinan.

## Documentation
* Business Requirements
* Data Dictionary
* ETL Documentation
* User Manual
* Operations Manual

## Testing
* Data Quality Tests
* Performance Tests
* UAT Results

## Project Timeline
* **Misi 1** (Weeks 1–4): Completed
* **Misi 2** (Weeks 5–9): Completed
* **Misi 3** (Weeks 10–14): Completed

## Security
* Role-based access control
* Data masking untuk data sensitif
* Audit trail untuk perubahan data
* Dokumentasi keamanan tersedia pada folder implementation

## License
Project ini dikembangkan sebagai bagian dari mata kuliah Pergudangan Data di Institut Teknologi Sumatera.

## Acknowledgments
* Program Studi Sains Data, Fakultas Sains, ITERA
* Dosen Pengampu: Yuliana, M.Sc
* Stakeholders Fakultas Teknologi Industri

## Contact
Untuk pertanyaan, hubungi project lead atau buka *issue* pada repository.
