<div align="center">

  <img src="assets/banner.svg" alt="windows-fix-toolkit Banner" width="100%" />

  <br /><br />

  [![Release](https://img.shields.io/github/v/release/ZidanAlfarizaPutraPratama/windows-fix-toolkit?style=for-the-badge&color=F59E0B&label=Versi%20Terbaru)](https://github.com/ZidanAlfarizaPutraPratama/windows-fix-toolkit/releases/latest)
  [![Downloads](https://img.shields.io/github/downloads/ZidanAlfarizaPutraPratama/windows-fix-toolkit/total?style=for-the-badge&color=10B981&label=Total%20Unduhan)](https://github.com/ZidanAlfarizaPutraPratama/windows-fix-toolkit/releases)
  [![Platform](https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011-0078D6?style=for-the-badge&logo=windows&logoColor=white)](https://www.microsoft.com/windows)
  [![License](https://img.shields.io/badge/License-MIT-6366F1?style=for-the-badge)](LICENSE)

  <p align="center">
    <strong>Utilitas perbaikan sistem, pemeliharaan jaringan, pembersih shader GPU, dan optimasi performa Windows bertenaga PowerShell.</strong>
  </p>

  <p align="center">
    <a href="#log-versi-dan-download">Log Versi & Download</a> •
    <a href="#fitur-utama">Fitur Utama</a> •
    <a href="#cara-menggunakan">Cara Menggunakan</a> •
    <a href="#lisensi">Lisensi</a>
  </p>

</div>

---

## Log Versi dan Download

Pilih versi yang ingin diunduh secara langsung (**hanya file aplikasi**, tanpa perlu mengunduh seluruh isi repositori):

| Versi | Status | Tanggal Rilis | Catatan Pembaruan (Changelog) | Unduh Langsung |
| :---: | :---: | :---: | :--- | :---: |
| **`v1.0.0.2`** | ![Latest](https://img.shields.io/badge/Terbaru-10B981?style=flat-square) | 23 Nov 2026 | **Kelola History Terminal, Purge Standby Cache & Urutan Menu:** Tambahan menu `[10]` kelola & nonaktifkan *history* PowerShell/CMD/Git Bash + reset bawaan, pembersihan *Standby Cache* di menu `[14]`, serta pengurutan ulang nomor menu `[1]`–`[15]`. | [⬇ **EXE**](https://github.com/ZidanAlfarizaPutraPratama/windows-fix-toolkit/releases/download/v1.0.0.2/windows-fix-toolkit.exe) • [📄 **BAT**](https://github.com/ZidanAlfarizaPutraPratama/windows-fix-toolkit/releases/download/v1.0.0.2/windows-fix-toolkit.bat) |
| **`v1.0.0.1`** | ![Archive](https://img.shields.io/badge/Arsip-6B7280?style=flat-square) | 22 Nov 2026 | **Perbaikan Stabilitas, Pembersih RAM & Build:** Perbaikan sintaks menu `[4]`, `[5]`, `[8]`, kelengkapan menu `[9]`–`[13]`, tambahan menu bersihkan RAM usage, dan backup otomatis `.exe` lama di `build-exe.ps1`. | [⬇ **EXE**](https://github.com/ZidanAlfarizaPutraPratama/windows-fix-toolkit/releases/download/v1.0.0.1/windows-fix-toolkit.exe) • [📄 **BAT**](https://github.com/ZidanAlfarizaPutraPratama/windows-fix-toolkit/releases/download/v1.0.0.1/windows-fix-toolkit.bat) |
| **`v1.0.0`** | ![Archive](https://img.shields.io/badge/Arsip-6B7280?style=flat-square) | 22 Nov 2026 | **Rilis Perdana:** 12 menu perbaikan & optimasi gaming + fitur auto-updater & cek changelog. | [⬇ **EXE**](https://github.com/ZidanAlfarizaPutraPratama/windows-fix-toolkit/releases/download/v1.0.0/windows-fix-toolkit.exe) • [📄 **BAT**](https://github.com/ZidanAlfarizaPutraPratama/windows-fix-toolkit/releases/download/v1.0.0/windows-fix-toolkit.bat) |

> **Tips:** Klik **⬇ EXE** untuk aplikasi berikon kustom, atau **📄 BAT** jika ingin melihat dan menjalankan kode skrip mentahnya secara langsung.

---

## Fitur Utama

### 🛠️ Perbaikan & Pemeliharaan Sistem

| No | Menu | Fungsi & Mekanisme PowerShell |
| :-: | :--- | :--- |
| **`[1]`** | **Scan & Perbaiki File Sistem** | Menjalankan `sfc /scannow` untuk memindai dan mengganti file sistem Windows yang korup. |
| **`[2]`** | **Perbaiki Windows Image** | Menjalankan `DISM /CheckHealth` dan `/RestoreHealth` untuk memulihkan *component store* Windows. |
| **`[3]`** | **Reset Jaringan & Cache DNS** | Membersihkan DNS *cache* (`Clear-DnsClientCache`), memperbarui IP, serta mereset Winsock dan TCP/IP. |
| **`[4]`** | **Bersihkan File Sampah** | Menghapus file sementara di `%TEMP%`, `C:\Windows\Temp`, `Prefetch`, dan mengosongkan *Recycle Bin*. |
| **`[5]`** | **Reset Windows Update** | Menghentikan layanan update, mencadangkan folder `SoftwareDistribution` & `catroot2` dengan *timestamp*, lalu memulai ulang layanan. |
| **`[6]`** | **Restart Windows Explorer** | Memulai ulang proses `explorer.exe` secara instan saat *Taskbar* atau *Start Menu* membeku (*freeze*). |
| **`[7]`** | **Update Semua Aplikasi** | Memperbarui seluruh aplikasi terinstal secara massal menggunakan `winget upgrade --all`. |
| **`[8]`** | **Cek Kesehatan Disk & Baterai** | Menampilkan status fisik SSD/HDD (`Get-PhysicalDisk`) serta membuka laporan kesehatan baterai otomatis di browser (laptop). |
| **`[9]`** | **Spesifikasi Sistem & Uptime** | Menampilkan edisi OS, prosesor, total kapasitas RAM, dan durasi aktif sejak *boot* terakhir. |
| **`[10]`** | **Kelola History Terminal** | Menghapus & menonaktifkan penyimpanan riwayat perintah secara permanen di **PowerShell**, **CMD**, dan **Git Bash**, atau meresetnya kembali ke *default*. |

### ⚡ Optimasi Performa & Gaming

| No | Menu | Fungsi & Mekanisme PowerShell |
| :-: | :--- | :--- |
| **`[11]`** | **Optimasi Performa Windows** | Menyesuaikan responsivitas sistem dan menonaktifkan *Game DVR* serta aplikasi latar belakang yang membebani performa. |
| **`[12]`** | **Bersihkan Cache Shader GPU** | Menghapus sisa *shader cache* lama milik **DirectX** (`D3DSCache`), **NVIDIA**, **AMD**, dan **Intel** secara aman tanpa mengganggu file yang dikunci driver aktif. |
| **`[13]`** | **Power Plan Ultimate Performance** | Membuka kunci dan mengaktifkan skema daya *Ultimate Performance* secara otomatis. |
| **`[14]`** | **Bersihkan RAM & Standby Cache** | Merapikan *working set* proses non-kritis (`EmptyWorkingSet`) dan mengosongkan *Modified & Standby Cache* (`NtSetSystemInformation`), lalu menampilkan perbandingan sebelum & sesudah. |

### 🔄 Pembaruan Aplikasi

| No | Menu | Fungsi & Mekanisme PowerShell |
| :-: | :--- | :--- |
| **`[15]`** | **Cek Versi & Auto-Update** | Menampilkan daftar perubahan (*Changelog*) versi terkini serta mengecek pembaruan rilis langsung dari repositori GitHub. |

---

## Cara Menggunakan

1. Pilih versi pada tabel [Log Versi dan Download](#log-versi-dan-download), lalu klik **⬇ EXE**.
2. Klik dua kali file **`windows-fix-toolkit.exe`** yang sudah terunduh.
3. Pilih **Yes** ketika jendela *User Account Control* (UAC) muncul untuk memberikan izin Administrator — **run saja ini aman kok 100%** (izin Administrator diperlukan agar fitur perbaikan sistem seperti SFC, DISM, layanan Windows Update, dan manajemen daya bisa berjalan).
4. Masukkan angka menu (`1`–`15`) sesuai kebutuhan, lalu tekan **Enter**.

---

## Penafian (Disclaimer)

Menu pada bagian **Optimasi Performa & Gaming** serta **Kelola History Terminal** memodifikasi nilai *Windows Registry*, konfigurasi profil shell, manajemen daya, atau *working set* memori proses. Sangat disarankan untuk membuat **System Restore Point** terlebih dahulu sebelum menerapkan perubahan sistem. Penggunaan aplikasi ini sepenuhnya berada di bawah tanggung jawab pengguna.

---

## Lisensi

Proyek ini dirilis di bawah lisensi **MIT License** — silakan lihat file [LICENSE](LICENSE) untuk detail selengkapnya.