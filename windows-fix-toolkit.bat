@echo off
setlocal EnableDelayedExpansion
set "APP_VERSION=1.0.0.2"
set "GITHUB_USER=ZidanAlfarizaPutraPratama"
set "GITHUB_REPO=windows-fix-toolkit"
title windows-fix-toolkit v%APP_VERSION% - PowerShell Edition
color 0B

:: Otomatis meminta izin Administrator jika belum dijalankan sebagai Admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta hak akses Administrator...
    if defined WINFIX_EXE_PATH (
        powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath $env:WINFIX_EXE_PATH -Verb RunAs"
    ) else (
        set "SCRIPT_PATH=%~f0"
        powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath $env:SCRIPT_PATH -Verb RunAs"
    )
    exit /b
)

if not defined WINFIX_EXE_PATH cd /d "%~dp0"

:: Bersihkan sisa file .old hasil auto-update sebelumnya (jika ada)
if defined WINFIX_EXE_PATH if exist "%WINFIX_EXE_PATH%.old" del /f /q "%WINFIX_EXE_PATH%.old" >nul 2>&1
if exist "%~f0.old" del /f /q "%~f0.old" >nul 2>&1

:MENU
cls
echo ============================================================================
echo               WINDOWS-FIX-TOOLKIT v%APP_VERSION% (POWERSHELL EDITION)
echo ============================================================================
echo.
echo   --- PERBAIKAN ^& PEMELIHARAAN SISTEM ---
echo   [1]  Scan ^& Perbaiki File Sistem (SFC Scannow)
echo   [2]  Perbaiki Windows Image (DISM RestoreHealth)
echo   [3]  Reset Jaringan ^& Bersihkan Cache DNS
echo   [4]  Bersihkan File Sampah (Temp ^& Recycle Bin)
echo   [5]  Reset Komponen Windows Update (Fix Update Macet/Error)
echo   [6]  Restart Windows Explorer (Fix Taskbar / Start Menu Freeze)
echo   [7]  Update Semua Aplikasi Terinstal (Winget Upgrade)
echo   [8]  Cek Kesehatan Disk (SSD/HDD) ^& Laporan Baterai
echo   [9]  Tampilkan Spesifikasi Sistem ^& Uptime
echo   [10] Kelola History Terminal (PowerShell, CMD ^& Git Bash)
echo.
echo   --- OPTIMASI PERFORMA ^& GAMING ---
echo   [11] Optimasi Performa Windows (Responsivitas, Game DVR ^& Background)
echo   [12] Bersihkan Cache Shader GPU (DirectX, NVIDIA, AMD, Intel)
echo   [13] Aktifkan Power Plan Ultimate Performance
echo   [14] Bersihkan RAM ^& Standby Cache (Trim Working Set ^& Purge Cache)
echo.
echo   --- APLIKASI ---
echo   [15] Cek Versi Terbaru, Lihat Changelog ^& Auto-Update
echo   [0]  Keluar
echo.
echo ============================================================================
set "pilihan="
set /p "pilihan=Masukkan nomor pilihan [0-15]: "

if not defined pilihan goto MENU
set "pilihan=%pilihan:"=%"
set "pilihan=%pilihan: =%"
if "%pilihan%"=="" goto MENU

if "%pilihan%"=="1" goto OPT1
if "%pilihan%"=="2" goto OPT2
if "%pilihan%"=="3" goto OPT3
if "%pilihan%"=="4" goto OPT4
if "%pilihan%"=="5" goto OPT5
if "%pilihan%"=="6" goto OPT6
if "%pilihan%"=="7" goto OPT7
if "%pilihan%"=="8" goto OPT8
if "%pilihan%"=="9" goto OPT9
if "%pilihan%"=="10" goto OPT10
if "%pilihan%"=="11" goto OPT11
if "%pilihan%"=="12" goto OPT12
if "%pilihan%"=="13" goto OPT13
if "%pilihan%"=="14" goto OPT14
if "%pilihan%"=="15" goto OPT15
if "%pilihan%"=="0" goto EXIT_APP

echo.
echo [!] Pilihan tidak valid. Silakan ketik angka 0 sampai 15.
timeout /t 2 >nul
goto MENU

:OPT1
cls
echo [1] Menjalankan System File Checker (SFC) via PowerShell...
echo Proses ini memakan waktu beberapa menit. Jangan tutup jendela ini.
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host 'Memulai SFC /scannow...' -ForegroundColor Cyan; sfc /scannow; Write-Host 'Proses SFC selesai!' -ForegroundColor Green"
echo.
pause
goto MENU

:OPT2
cls
echo [2] Menjalankan DISM CheckHealth ^& RestoreHealth via PowerShell...
echo Pastikan koneksi internet aktif. Proses bisa memakan waktu 5-15 menit.
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host 'Langkah 1/2: Memeriksa kesehatan image...' -ForegroundColor Cyan; DISM /Online /Cleanup-Image /CheckHealth; Write-Host 'Langkah 2/2: Memperbaiki Windows image...' -ForegroundColor Cyan; DISM /Online /Cleanup-Image /RestoreHealth; Write-Host 'Proses DISM selesai!' -ForegroundColor Green"
echo.
pause
goto MENU

:OPT3
cls
echo [3] Mereset Konfigurasi Jaringan ^& DNS via PowerShell...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host 'Membersihkan DNS Cache...' -ForegroundColor Cyan; Clear-DnsClientCache; ipconfig /flushdns | Out-Null; Write-Host 'Memperbarui IP Address...' -ForegroundColor Cyan; ipconfig /release | Out-Null; ipconfig /renew | Out-Null; Write-Host 'Mereset Winsock & TCP/IP...' -ForegroundColor Cyan; netsh winsock reset; netsh int ip reset; Write-Host 'Reset jaringan selesai! Restart PC jika koneksi masih bermasalah.' -ForegroundColor Green"
echo.
pause
goto MENU

:OPT4
cls
echo [4] Membersihkan File Sementara (Temp) ^& Recycle Bin via PowerShell...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$folders = @($env:TEMP, 'C:\Windows\Temp', 'C:\Windows\Prefetch'); foreach ($f in $folders) { if (Test-Path $f) { Write-Host ('Membersihkan: ' + $f) -ForegroundColor Cyan; Get-ChildItem -Path $f -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue } }; Write-Host 'Mengosongkan Recycle Bin...' -ForegroundColor Cyan; Clear-RecycleBin -Force -ErrorAction SilentlyContinue; Write-Host 'Pembersihan file sampah selesai!' -ForegroundColor Green"
echo.
pause
goto MENU

:OPT5
cls
echo [5] Mereset Komponen Windows Update via PowerShell...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ts = Get-Date -Format 'yyyyMMdd_HHmmss'; $svcs = @('wuauserv', 'cryptSvc', 'bits', 'msiserver'); Write-Host 'Menghentikan layanan Windows Update...' -ForegroundColor Cyan; foreach ($s in $svcs) { Stop-Service -Name $s -Force -ErrorAction SilentlyContinue }; if (Test-Path 'C:\Windows\SoftwareDistribution') { Rename-Item -Path 'C:\Windows\SoftwareDistribution' -NewName ('SoftwareDistribution.bak_' + $ts) -ErrorAction SilentlyContinue }; if (Test-Path 'C:\Windows\System32\catroot2') { Rename-Item -Path 'C:\Windows\System32\catroot2' -NewName ('catroot2.bak_' + $ts) -ErrorAction SilentlyContinue }; Write-Host 'Menjalankan kembali layanan Windows Update...' -ForegroundColor Cyan; foreach ($s in $svcs) { Start-Service -Name $s -ErrorAction SilentlyContinue }; Write-Host 'Komponen Windows Update berhasil direset!' -ForegroundColor Green"
echo.
pause
goto MENU

:OPT6
cls
echo [6] Merestart Windows Explorer via PowerShell...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host 'Menghentikan Explorer...' -ForegroundColor Cyan; Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue; Start-Sleep -Seconds 2; if (-not (Get-Process -Name explorer -ErrorAction SilentlyContinue)) { Start-Process explorer }; Write-Host 'Windows Explorer berhasil direstart!' -ForegroundColor Green"
echo.
pause
goto MENU

:OPT7
cls
echo [7] Memperbarui Semua Aplikasi via Winget (PowerShell)...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "if (Get-Command winget -ErrorAction SilentlyContinue) { Write-Host 'Mencari dan menginstal pembaruan aplikasi...' -ForegroundColor Cyan; winget upgrade --all --include-unknown --accept-package-agreements --accept-source-agreements } else { Write-Host 'Winget tidak ditemukan di sistem ini. Silakan update App Installer di Microsoft Store.' -ForegroundColor Yellow }"
echo.
pause
goto MENU

:OPT8
cls
echo [8] Memeriksa Kesehatan Penyimpanan ^& Baterai via PowerShell...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host '=== STATUS KESEHATAN DISK (SSD/HDD) ===' -ForegroundColor Cyan; Get-PhysicalDisk | Select-Object FriendlyName, MediaType, HealthStatus, OperationalStatus, @{Name='SizeGB';Expression={[math]::Round($_.Size/1GB, 2)}} | Format-Table -AutoSize; $bat = Get-CimInstance -ClassName Win32_Battery -ErrorAction SilentlyContinue; if ($bat) { Write-Host 'Membuat laporan kesehatan baterai...' -ForegroundColor Cyan; $rep = Join-Path $env:TEMP 'battery-report.html'; powercfg /batteryreport /output $rep | Out-Null; if (Test-Path $rep) { Start-Process $rep; Write-Host 'Laporan baterai dibuka di browser.' -ForegroundColor Green } } else { Write-Host 'Perangkat ini tidak menggunakan baterai (PC Desktop).' -ForegroundColor Yellow }"
echo.
pause
goto MENU

:OPT9
cls
echo [9] Informasi Spesifikasi Sistem ^& Uptime via PowerShell...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$os = Get-CimInstance Win32_OperatingSystem; $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1; $ramGB = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2); $uptime = (Get-Date) - $os.LastBootUpTime; Write-Host ('OS      : ' + $os.Caption + ' (' + $os.OSArchitecture + ')') -ForegroundColor Cyan; Write-Host ('CPU     : ' + $cpu.Name.Trim()) -ForegroundColor Cyan; Write-Host ('RAM     : ' + $ramGB + ' GB') -ForegroundColor Cyan; Write-Host ('Uptime  : ' + $uptime.Days + 'h ' + $uptime.Hours + 'j ' + $uptime.Minutes + 'm') -ForegroundColor Green"
echo.
pause
goto MENU

:OPT10
cls
echo ============================================================================
echo          [10] KELOLA HISTORY TERMINAL (POWERSHELL, CMD ^& GIT BASH)
echo ============================================================================
echo.
echo   [1] Hapus History ^& Matikan Simpan Otomatis (PowerShell, CMD ^& Git Bash)
echo   [2] Reset / Kembalikan Setelan History ke Default
echo   [0] Kembali ke Menu Utama
echo.
echo ============================================================================
set "subpil="
set /p "subpil=Pilih tindakan [0-2]: "

if not defined subpil goto OPT10
set "subpil=%subpil:"=%"
set "subpil=%subpil: =%"
if "%subpil%"=="" goto OPT10

if "%subpil%"=="1" goto OPT10_OFF
if "%subpil%"=="2" goto OPT10_RESET
if "%subpil%"=="0" goto MENU

echo.
echo [!] Pilihan tidak valid. Ketik angka 0 sampai 2.
timeout /t 2 >nul
goto OPT10

:OPT10_OFF
echo.
doskey /reinit >nul 2>&1
doskey /listsize=0 >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "$psHist = (Get-PSReadLineOption).HistorySavePath; if ($psHist -and (Test-Path $psHist)) { Remove-Item $psHist -Force -ErrorAction SilentlyContinue }; if (-not (Test-Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force | Out-Null }; $profContent = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue; if ($profContent -notmatch 'SaveNothing') { Add-Content -Path $PROFILE -Value 'Set-PSReadLineOption -HistorySaveStyle SaveNothing' }; try { Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force -ErrorAction Stop } catch {}; Write-Host 'PowerShell : History dihapus & penyimpanan otomatis dimatikan.' -ForegroundColor Green; $regPath = 'HKCU:\Software\Microsoft\Command Processor'; if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }; $curAuto = (Get-ItemProperty -Path $regPath -Name 'AutoRun' -ErrorAction SilentlyContinue).AutoRun; if ([string]::IsNullOrWhiteSpace($curAuto)) { Set-ItemProperty -Path $regPath -Name 'AutoRun' -Value 'doskey /listsize=0' -Type String } elseif ($curAuto -notmatch 'doskey\s+/listsize=0') { Set-ItemProperty -Path $regPath -Name 'AutoRun' -Value ($curAuto.Trim() + ' & doskey /listsize=0') -Type String }; Write-Host 'CMD        : Buffer history dihapus & dimatikan (doskey /listsize=0).' -ForegroundColor Green; $bashHist = Join-Path $env:USERPROFILE '.bash_history'; if (Test-Path $bashHist) { Remove-Item $bashHist -Force -ErrorAction SilentlyContinue }; $bashrc = Join-Path $env:USERPROFILE '.bashrc'; if (-not (Test-Path $bashrc)) { New-Item -ItemType File -Path $bashrc -Force | Out-Null }; $bashContent = Get-Content $bashrc -Raw -ErrorAction SilentlyContinue; if ($bashContent -notmatch 'HISTSIZE=0') { $utf8NoBom = New-Object System.Text.UTF8Encoding($false); [System.IO.File]::AppendAllText($bashrc, [char]10 + 'export HISTSIZE=0' + [char]10 + 'export HISTFILESIZE=0' + [char]10 + 'unset HISTFILE' + [char]10, $utf8NoBom) }; Write-Host 'Git Bash   : History dihapus & penyimpanan otomatis dimatikan.' -ForegroundColor Green"
echo.
pause
goto OPT10

:OPT10_RESET
echo.
doskey /listsize=50 >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "if (Test-Path $PROFILE) { $lines = @(Get-Content $PROFILE | Where-Object { $_ -notmatch 'SaveNothing' -and $_.Trim() -ne '' }); if ($lines.Count -gt 0) { Set-Content -Path $PROFILE -Value $lines } else { Remove-Item $PROFILE -Force -ErrorAction SilentlyContinue } }; try { Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser -Force -ErrorAction Stop } catch {}; Write-Host 'PowerShell : Setelan history & execution policy dikembalikan ke default.' -ForegroundColor Green; $regPath = 'HKCU:\Software\Microsoft\Command Processor'; $curAuto = (Get-ItemProperty -Path $regPath -Name 'AutoRun' -ErrorAction SilentlyContinue).AutoRun; if (-not [string]::IsNullOrWhiteSpace($curAuto)) { $newAuto = ($curAuto -replace '\s*&\s*doskey\s+/listsize=0', '' -replace 'doskey\s+/listsize=0\s*&\s*', '' -replace 'doskey\s+/listsize=0', '').Trim(); if ([string]::IsNullOrWhiteSpace($newAuto)) { Remove-ItemProperty -Path $regPath -Name 'AutoRun' -ErrorAction SilentlyContinue } else { Set-ItemProperty -Path $regPath -Name 'AutoRun' -Value $newAuto -Type String } }; Write-Host 'CMD        : Buffer history dikembalikan ke default (listsize=50).' -ForegroundColor Green; $bashrc = Join-Path $env:USERPROFILE '.bashrc'; if (Test-Path $bashrc) { $bLines = @(Get-Content $bashrc | Where-Object { $_ -notmatch '^(export HISTSIZE=0|export HISTFILESIZE=0|unset HISTFILE)$' -and $_.Trim() -ne '' }); $utf8NoBom = New-Object System.Text.UTF8Encoding($false); if ($bLines.Count -gt 0) { [System.IO.File]::WriteAllText($bashrc, ($bLines -join [char]10) + [char]10, $utf8NoBom) } else { [System.IO.File]::WriteAllText($bashrc, '', $utf8NoBom) } }; Write-Host 'Git Bash   : Setelan history dikembalikan ke default.' -ForegroundColor Green"
echo.
pause
goto OPT10

:OPT11
cls
echo [11] Optimasi Performa Windows...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR' -Name 'AppCaptureEnabled' -Value 0 -Type DWord -ErrorAction SilentlyContinue; Set-ItemProperty -Path 'HKCU:\System\GameConfigStore' -Name 'GameDVR_Enabled' -Value 0 -Type DWord -ErrorAction SilentlyContinue; Write-Host 'Game DVR dinonaktifkan. Cek pengaturan Background Apps di Settings Windows jika diperlukan.' -ForegroundColor Green"
echo.
pause
goto MENU

:OPT12
cls
echo [12] Membersihkan Cache Shader GPU...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$shaderPaths = @((Join-Path $env:LOCALAPPDATA 'D3DSCache'), (Join-Path $env:LOCALAPPDATA 'NVIDIA\GLCache'), (Join-Path $env:LOCALAPPDATA 'NVIDIA\DXCache'), (Join-Path $env:LOCALAPPDATA 'AMD\DxCache'), (Join-Path $env:LOCALAPPDATA 'Intel\ShaderCache')); foreach ($p in $shaderPaths) { if (Test-Path $p) { Write-Host ('Membersihkan: ' + $p) -ForegroundColor Cyan; Get-ChildItem -Path $p -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue } }; Write-Host 'Cache shader GPU selesai dibersihkan!' -ForegroundColor Green"
echo.
pause
goto MENU

:OPT13
cls
echo [13] Mengaktifkan Power Plan Ultimate Performance...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$exists = powercfg /list | Select-String -Pattern 'Ultimate Performance'; if (-not $exists) { powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null }; $guid = (powercfg /list | ForEach-Object { if ($_ -match '([0-9a-fA-F-]{36}).*Ultimate Performance') { $matches[1] } } | Select-Object -First 1); if ($guid) { powercfg /setactive $guid; Write-Host ('Power Plan Ultimate Performance aktif (' + $guid + ').') -ForegroundColor Green } else { Write-Host 'Ultimate Performance tidak didukung di edisi/perangkat ini.' -ForegroundColor Yellow }"
echo.
pause
goto MENU

:OPT14
cls
echo [14] Membersihkan RAM ^& Standby Cache (Trim Working Set ^& Purge Cache)...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$code = 'using System; using System.Runtime.InteropServices; public class MemClean { [DllImport(\"psapi.dll\")] public static extern bool EmptyWorkingSet(IntPtr h); [DllImport(\"ntdll.dll\")] public static extern int NtSetSystemInformation(int cls, ref int info, int len); [DllImport(\"advapi32.dll\", SetLastError=true)] public static extern bool OpenProcessToken(IntPtr h, uint acc, out IntPtr tok); [DllImport(\"advapi32.dll\", SetLastError=true, CharSet=CharSet.Auto)] public static extern bool LookupPrivilegeValue(string sys, string name, out LUID luid); [DllImport(\"advapi32.dll\", SetLastError=true)] public static extern bool AdjustTokenPrivileges(IntPtr tok, bool dis, ref TP tp, int len, IntPtr prev, IntPtr ret); [DllImport(\"kernel32.dll\", SetLastError=true)] public static extern bool CloseHandle(IntPtr h); [StructLayout(LayoutKind.Sequential)] public struct LUID { public uint Low; public int High; } [StructLayout(LayoutKind.Sequential)] public struct TP { public uint Count; public LUID Luid; public uint Attr; } public static bool EnablePriv(string n) { IntPtr t; if (OpenProcessToken(System.Diagnostics.Process.GetCurrentProcess().Handle, 40, out t) == false) return false; LUID l; if (LookupPrivilegeValue(null, n, out l) == false) { CloseHandle(t); return false; } TP tp = new TP(); tp.Count = 1; tp.Luid = l; tp.Attr = 2; bool r = AdjustTokenPrivileges(t, false, ref tp, 0, IntPtr.Zero, IntPtr.Zero); CloseHandle(t); return r; } public static void PurgeCache() { EnablePriv(\"SeProfileSingleProcessPrivilege\"); EnablePriv(\"SeIncreaseQuotaPrivilege\"); int c2 = 2; NtSetSystemInformation(80, ref c2, 4); int c3 = 3; NtSetSystemInformation(80, ref c3, 4); int c4 = 4; NtSetSystemInformation(80, ref c4, 4); } }'; Add-Type -TypeDefinition $code -ErrorAction SilentlyContinue; $freeBefore = (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB; $perfBefore = Get-CimInstance Win32_PerfFormattedData_PerfOS_Memory -ErrorAction SilentlyContinue; $cacheBefore = ($perfBefore.StandbyCacheNormalPriorityBytes + $perfBefore.StandbyCacheReserveBytes + $perfBefore.StandbyCacheCoreBytes + $perfBefore.ModifiedPageListBytes) / 1GB; Write-Host ('Free RAM Sebelum      : ' + [math]::Round($freeBefore, 2) + ' GB') -ForegroundColor Cyan; Write-Host ('Standby Cache Sebelum : ' + [math]::Round($cacheBefore, 2) + ' GB') -ForegroundColor Cyan; Write-Host 'Melakukan Trim Working Set proses...' -ForegroundColor Yellow; Get-Process | Where-Object { $_.Id -gt 4 -and $_.ProcessName -notmatch 'System|Idle|csrss|wininit|services|lsass|smss|dwm' } | ForEach-Object { try { if ($_.Handle -ne [IntPtr]::Zero) { [MemClean]::EmptyWorkingSet($_.Handle) | Out-Null } } catch {} }; Write-Host 'Membersihkan Modified & Standby Cache...' -ForegroundColor Yellow; [MemClean]::PurgeCache(); [GC]::Collect(); [GC]::WaitForPendingFinalizers(); Start-Sleep -Seconds 1; $freeAfter = (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB; $perfAfter = Get-CimInstance Win32_PerfFormattedData_PerfOS_Memory -ErrorAction SilentlyContinue; $cacheAfter = ($perfAfter.StandbyCacheNormalPriorityBytes + $perfAfter.StandbyCacheReserveBytes + $perfAfter.StandbyCacheCoreBytes + $perfAfter.ModifiedPageListBytes) / 1GB; $diffFree = [math]::Round($freeAfter - $freeBefore, 2); Write-Host ('Free RAM Sesudah      : ' + [math]::Round($freeAfter, 2) + ' GB (' + $(if ($diffFree -ge 0) { '+' + $diffFree } else { $diffFree }) + ' GB)') -ForegroundColor Green; Write-Host ('Standby Cache Sesudah : ' + [math]::Round($cacheAfter, 2) + ' GB') -ForegroundColor Green"
echo.
pause
goto MENU

:OPT15
setlocal DisableDelayedExpansion
cls
echo ============================================================================
echo            [15] CEK VERSI TERBARU, CHANGELOG ^& AUTO-UPDATE
echo ============================================================================
echo.
set "CURR_BAT=%~f0"
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$curr = '%APP_VERSION%';" ^
  "$url = 'https://api.github.com/repos/%GITHUB_USER%/%GITHUB_REPO%/releases/latest';" ^
  "try {" ^
  "  $rel = Invoke-RestMethod -Uri $url -Headers @{'User-Agent'='windows-fix-toolkit'} -TimeoutSec 10;" ^
  "  $tag = $rel.tag_name.Trim();" ^
  "  $lat = $tag -replace '^v', '';" ^
  "  Write-Host ('  Versi Terpasang : v' + $curr) -ForegroundColor Cyan;" ^
  "  Write-Host ('  Rilis GitHub    : ' + $tag) -ForegroundColor Green;" ^
  "  $vC = [version]$curr; $vL = [version]$lat;" ^
  "  if ($vL -gt $vC) { Write-Host '  Status          : [UPDATE] Tersedia versi terbaru di GitHub' -ForegroundColor Yellow }" ^
  "  elseif ($vL -eq $vC) { Write-Host '  Status          : [OK] Sudah menggunakan versi terbaru' -ForegroundColor Green }" ^
  "  else { Write-Host '  Status          : [DEV] Versi lokal lebih baru dari rilis GitHub' -ForegroundColor Magenta };" ^
  "  Write-Host '----------------------------------------------------------------------------' -ForegroundColor DarkGray;" ^
  "  if ($vC -gt $vL) {" ^
  "    Write-Host ''; Write-Host ('  [ CHANGELOG LOKAL v' + $curr + ' ]') -ForegroundColor Cyan;" ^
  "    Write-Host '  + Menu [10] Kelola History Terminal (PowerShell, CMD & Git Bash)' -ForegroundColor White;" ^
  "    Write-Host '      * Hapus history & matikan simpan otomatis permanen' -ForegroundColor Gray;" ^
  "    Write-Host '      * Reset / kembalikan setelan history ke default' -ForegroundColor Gray;" ^
  "    Write-Host '  + Peningkatan Menu [14] Bersihkan RAM & Standby Cache' -ForegroundColor White;" ^
  "    Write-Host '      * Tambah pembersihan Modified & Standby Cache' -ForegroundColor Gray;" ^
  "    Write-Host '      * Tampilkan perbandingan Free RAM & Standby Cache' -ForegroundColor Gray;" ^
  "    Write-Host '  + Pengurutan ulang nomor menu [1]-[15] sesuai kategori' -ForegroundColor White;" ^
  "  };" ^
  "  if ($rel.body) {" ^
  "    Write-Host ''; Write-Host ('  [ CATATAN RILIS GITHUB (' + $tag + ') ]') -ForegroundColor Yellow;" ^
  "    foreach ($rawLine in ($rel.body -split [char]10)) {" ^
  "      $c = ($rawLine.TrimEnd([char]13) -replace '[[]cite:[^]]*[]]', '').Replace('**', '').Replace([string][char]96, '');" ^
  "      if ($c -match '^###[ ]+(.+)$') { Write-Host ''; Write-Host ('  > ' + $matches[1].Trim()) -ForegroundColor Cyan }" ^
  "      elseif ($c -match '^-[ ]+(.+)$') { Write-Host ('    - ' + $matches[1].Trim()) -ForegroundColor Gray }" ^
  "      elseif (-not [string]::IsNullOrWhiteSpace($c)) { Write-Host ('    ' + $c.Trim()) -ForegroundColor Gray }" ^
  "    }" ^
  "  };" ^
  "  Write-Host ''; Write-Host '----------------------------------------------------------------------------' -ForegroundColor DarkGray;" ^
  "  if ($vL -gt $vC) { exit 10 }" ^
  "} catch {" ^
  "  Write-Host ('  [ERROR] Gagal mengecek rilis GitHub: ' + $_.Exception.Message) -ForegroundColor Red" ^
  "}"

if %errorlevel% neq 10 goto OPT15_END
set "do_upd="
set /p "do_upd=  Unduh dan pasang update sekarang? [Y/N]: "
if /i "%do_upd%"=="Y" goto DO_UPDATE

:OPT15_END
endlocal
echo.
pause
goto MENU

:DO_UPDATE
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$url = 'https://api.github.com/repos/%GITHUB_USER%/%GITHUB_REPO%/releases/latest';" ^
  "try {" ^
  "  $rel = Invoke-RestMethod -Uri $url -Headers @{'User-Agent'='windows-fix-toolkit'} -TimeoutSec 15;" ^
  "  $isExe = [bool]$env:WINFIX_EXE_PATH;" ^
  "  $target = if ($isExe) { $env:WINFIX_EXE_PATH } else { $env:CURR_BAT };" ^
  "  $assetName = if ($isExe) { 'windows-fix-toolkit.exe' } else { 'windows-fix-toolkit.bat' };" ^
  "  $asset = $rel.assets | Where-Object { $_.name -eq $assetName } | Select-Object -First 1;" ^
  "  if (-not $asset) { Write-Host ('  [ERROR] File ' + $assetName + ' tidak ditemukan di rilis GitHub.') -ForegroundColor Red; exit 1 };" ^
  "  $tmpNew = $target + '.new';" ^
  "  $tmpOld = $target + '.old';" ^
  "  Write-Host ('  Mengunduh ' + $assetName + '...') -ForegroundColor Cyan;" ^
  "  Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $tmpNew -UseBasicParsing;" ^
  "  if (Test-Path $tmpOld) { Remove-Item $tmpOld -Force -ErrorAction SilentlyContinue };" ^
  "  Move-Item -Path $target -Destination $tmpOld -Force;" ^
  "  Move-Item -Path $tmpNew -Destination $target -Force;" ^
  "  Write-Host '  Update berhasil diterapkan! Menjalankan ulang aplikasi...' -ForegroundColor Green;" ^
  "  Start-Sleep -Seconds 2;" ^
  "  Start-Process -FilePath $target;" ^
  "  exit 99" ^
  "} catch {" ^
  "  Write-Host ('  [ERROR] Gagal mengunduh update: ' + $_.Exception.Message) -ForegroundColor Red" ^
  "}"
if %errorlevel% equ 99 (
    endlocal
    goto EXIT_APP
)
endlocal
echo.
pause
goto MENU

:EXIT_APP
endlocal
exit /b 0