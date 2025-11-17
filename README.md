# *Data Mart Fakultas Teknologi Industri (FTI) - Institut Teknologi Sumatera*

## *Project Overview*
Data mart Fakultas Teknologi Industri (FTI) dibangun untuk mengintegrasikan berbagai sumber data akademik dan administratif yang sebelumnya tersebar pada banyak file dan sistem terpisah. Dengan mengkonsolidasikan data terkait mahasiswa, dosen, prestasi, akreditasi, dan anggaran ke dalam satu struktur dimensional, data mart ini menyediakan informasi yang lebih terorganisir, akurat, dan mudah diakses untuk keperluan analisis. Proses ini membuat penyusunan laporan, evaluasi rutin, serta monitoring kinerja fakultas menjadi lebih cepat dan konsisten.

Secara bisnis, data mart memberikan nilai strategis bagi pimpinan FTI karena memungkinkan analisis multidimensi seperti tren mahasiswa aktif, perkembangan mutu akademik, hingga efisiensi penggunaan anggaran. Informasi yang tersaji secara lebih komprehensif membantu pimpinan dalam pengambilan keputusan berbasis data, merencanakan strategi pengembangan fakultas, serta memenuhi kebutuhan pelaporan internal maupun eksternal. Dengan demikian, data mart menjadi fondasi penting dalam mendukung transformasi manajemen FTI menuju sistem yang lebih efektif dan data-driven.

## *Team Members*
| NIM        | Name                        | Role                         | Email                                   |
|------------|-----------------------------|------------------------------|-------------------------------------------|
| 123450115  | Muhammad Fadil Alfaizi      | Project Lead & Database Designer | fadil.123450115@student.itera.ac.id       |
| 122450108  | Andre Hadiman Rotua Parhusip| ETL Developer                | andre.122450108@student.itera.ac.id       |
| 123450008  | Nabyla Sharfina             | BI Developer                 | nabyla.123450008@student.itera.ac.id      |
| 123450069  | Arini Puteri Elandra        | Documentation & QA           | arini.123450069@student.itera.ac.id       |


## *Business Domain*
Description of the unit/department being analyzed:
- Key business processes
- Stakeholders                                            |
- Decision-making needs

## *Objectives*
1. Objective 1
2. Objective 2
3. Objective 3

## *Key Performance Indicators (KPIs)*
| **Proses Bisnis**                      | **KPI**                                       | **Frekuensi Pemantauan** |
| -------------------------------------- | --------------------------------------------- | ------------------------ |
| Manajemen Akademik Mahasiswa & Dosen   | Jumlah Mahasiswa Aktif per Program Studi      | Bulanan / Semester       |
| Manajemen Akademik Mahasiswa & Dosen   | IPK Rata-rata per Program Studi pada Masa TPB | Semester                 |
| Manajemen Kegiatan Mahasiswa           | Jumlah Prestasi Mahasiswa                     | Tahunan                  |
| Manajemen Keuangan & Anggaran Fakultas | Rata-rata Pengeluaran per Program Studi       | Bulanan                  |
| Evaluasi Kinerja & Akreditasi Fakultas | Indeks Kinerja Fakultas                       | Tahunan                  |


## *Architecture*
- **Approach**: Kimball Dimensional Modeling
- **Database**: SQL Server 2019 on Azure VM
- **ETL**: SQL Server Integration Services (SSIS)
- **Visualization**: Power BI Desktop
- **Version Control**: Git

### Data Model
![Dimensional Model]
