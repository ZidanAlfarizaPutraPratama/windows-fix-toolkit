# Changelog

Seluruh perubahan penting pada proyek **windows-fix-toolkit** dicatat dalam berkas ini.

## [1.0.0.2] - 2026-11-23
### Ditambahkan
- Menu **[10] Kelola History Terminal (PowerShell, CMD & Git Bash)** dengan sub-menu untuk menghapus riwayat perintah & mematikan penyimpanan otomatis secara permanen (`SaveNothing`, `doskey /listsize=0`, `HISTSIZE=0`) serta opsi reset ke setelan bawaan (*default*).
- Pembersihan **Modified & Standby Cache** via API `NtSetSystemInformation` (`SeProfileSingleProcessPrivilege`) pada menu **[14] Bersihkan RAM & Standby Cache**, lengkap dengan indikator kapasitas *Free RAM* dan *Standby Cache* sebelum serta sesudah pembersihan.
- Ringkasan *changelog* bawaan pada menu **[15] Cek Versi Terbaru, Lihat Changelog & Auto-Update**.

### Diubah & Diperbaiki
- Mengurutkan ulang penomoran menu menjadi **`[1]`–`[15]`** secara berurutan sesuai kategori (`[10]` untuk *Kelola History Terminal*, `[11]`–`[14]` untuk *Optimasi Performa & Gaming*, dan `[15]` untuk *Cek Versi & Auto-Update*).
- Memperbaiki kompatibilitas blok perintah PowerShell dengan `EnableDelayedExpansion` serta menangani pengecualian *override* `Set-ExecutionPolicy` secara bersih.

## [1.0.0.1] - 2026-11-22
### Diperbaiki
- Memperbaiki *syntax error* PowerShell pada menu pembersihan file sampah (`[4]`) akibat penulisan `Test-Path$f` dan `Get-ChildItem -Path$f` yang kurang spasi.
- Memperbaiki `ParserError` pada menu reset komponen Windows Update (`[5]`) akibat penulisan `foreach ($s in$svcs)` dan `Start-Service -Name$s` yang kurang spasi.
- Merapikan spasi argumen pada menu cek kesehatan disk & baterai (`[8]`) serta melengkapi alur menu spesifikasi sistem (`[9]`), optimasi performa (`[10]`), pembersihan *shader cache* GPU (`[11]`), *Power Plan Ultimate Performance* (`[12]`), dan pengecekan rilis/changelog (`[13]`) agar jendela tidak menutup sendiri saat dijalankan.

### Ditambahkan
- Menu **[14] Bersihkan RAM Usage** untuk merapikan *working set* proses non-kritis (`EmptyWorkingSet`), menjalankan *garbage collection*, serta menampilkan perbandingan kapasitas *Free RAM* sebelum dan sesudah pembersihan.
- Pencadangan otomatis berkas `windows-fix-toolkit.exe` lama ke folder `backup/` dengan *timestamp* sebelum proses kompilasi ulang di `build-exe.ps1`.
- Pencocokan pola versi (`APP_VERSION`) yang lebih toleran terhadap tanda kutip saat proses *build* `.exe`.

## [1.0.0] - 2026-11-22
### Ditambahkan
- **Perbaikan Sistem:** Menu `SFC /scannow`, `DISM RestoreHealth`, reset jaringan/DNS, pembersih file sementara, reset Windows Update, restart Explorer, dan pembaruan aplikasi massal via `winget`.
- **Diagnostik Perangkat:** Pemeriksaan kesehatan SSD/HDD (`Get-PhysicalDisk`), laporan baterai otomatis, serta ringkasan spesifikasi hardware & *uptime*.
- **Optimasi Performa & Gaming:** Penyesuaian `SystemResponsiveness`, penonaktifan *Game DVR* & P2P *Delivery Optimization*, pembersih *shader cache* GPU (DirectX, NVIDIA, AMD, Intel), dan aktivasi Power Plan *Ultimate Performance*.
- **Auto-Updater & Changelog:** Fitur pengecekan versi terbaru dan pembacaan catatan rilis langsung dari GitHub.