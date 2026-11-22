@echo off
setlocal EnableDelayedExpansion
set "APP_VERSION=1.0.0.1"
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
echo.
echo   --- OPTIMASI PERFORMA ^& GAMING ---
echo   [10] Optimasi Performa Windows (Responsivitas, Game DVR ^& Background)
echo   [11] Bersihkan Cache Shader GPU (DirectX, NVIDIA, AMD, Intel)
echo   [12] Aktifkan Power Plan Ultimate Performance
echo   [14] Bersihkan RAM Usage (Trim Working Set ^& Cek Free RAM)
echo.
echo   --- APLIKASI ---
echo   [13] Cek Versi Terbaru, Lihat Changelog ^& Auto-Update
echo   [0]  Keluar
echo.
echo ============================================================================
set "pilihan="
set /p "pilihan=Masukkan nomor pilihan [0-14]: "

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
if "%pilihan%"=="0" goto EXIT_APP

echo.
echo [!] Pilihan tidak valid. Silakan ketik angka 0 sampai 14.
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
echo [10] Optimasi Performa Windows...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR' -Name 'AppCaptureEnabled' -Value 0 -Type DWord -ErrorAction SilentlyContinue; Set-ItemProperty -Path 'HKCU:\System\GameConfigStore' -Name 'GameDVR_Enabled' -Value 0 -Type DWord -ErrorAction SilentlyContinue; Write-Host 'Game DVR dinonaktifkan. Cek pengaturan Background Apps di Settings Windows jika diperlukan.' -ForegroundColor Green"
echo.
pause
goto MENU

:OPT11
cls
echo [11] Membersihkan Cache Shader GPU...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$shaderPaths = @((Join-Path $env:LOCALAPPDATA 'D3DSCache'), (Join-Path $env:LOCALAPPDATA 'NVIDIA\GLCache'), (Join-Path $env:LOCALAPPDATA 'NVIDIA\DXCache'), (Join-Path $env:LOCALAPPDATA 'AMD\DxCache'), (Join-Path $env:LOCALAPPDATA 'Intel\ShaderCache')); foreach ($p in $shaderPaths) { if (Test-Path $p) { Write-Host ('Membersihkan: ' + $p) -ForegroundColor Cyan; Get-ChildItem -Path $p -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue } }; Write-Host 'Cache shader GPU selesai dibersihkan!' -ForegroundColor Green"
echo.
pause
goto MENU

:OPT12
cls
echo [12] Mengaktifkan Power Plan Ultimate Performance...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$exists = powercfg /list | Select-String -Pattern 'Ultimate Performance'; if (-not $exists) { powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null }; $guid = (powercfg /list | ForEach-Object { if ($_ -match '([0-9a-fA-F-]{36}).*Ultimate Performance') { $matches[1] } } | Select-Object -First 1); if ($guid) { powercfg /setactive $guid; Write-Host ('Power Plan Ultimate Performance aktif (' + $guid + ').') -ForegroundColor Green } else { Write-Host 'Ultimate Performance tidak didukung di edisi/perangkat ini.' -ForegroundColor Yellow }"
echo.
pause
goto MENU

:OPT13
cls
echo [13] Cek Versi Terbaru, Changelog ^& Auto-Update (%GITHUB_USER%/%GITHUB_REPO%)...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$url = 'https://api.github.com/repos/%GITHUB_USER%/%GITHUB_REPO%/releases/latest'; try { $rel = Invoke-RestMethod -Uri $url -Headers @{'User-Agent'='windows-fix-toolkit'} -TimeoutSec 10; Write-Host ('Versi Saat Ini : v%APP_VERSION%') -ForegroundColor Cyan; Write-Host ('Versi Terbaru  : ' + $rel.tag_name) -ForegroundColor Green; Write-Host '--- Changelog ---' -ForegroundColor Yellow; Write-Host $rel.body } catch { Write-Host ('Gagal mengecek rilis GitHub: ' + $_.Exception.Message) -ForegroundColor Red }"
echo.
pause
goto MENU

:OPT14
cls
echo [14] Membersihkan RAM Usage (Trim Working Set ^& Cek Free RAM)...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$before = (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB; Write-Host ('Free RAM Sebelum : ' + [math]::Round($before, 2) + ' GB') -ForegroundColor Cyan; Add-Type -Namespace Win32 -Name MemTrim -MemberDefinition '[DllImport(\"psapi.dll\")] public static extern bool EmptyWorkingSet(IntPtr hProcess);' -ErrorAction SilentlyContinue; Get-Process | Where-Object { $_.Id -gt 4 -and $_.ProcessName -notmatch 'System|Idle|csrss|wininit|services|lsass|smss|dwm' } | ForEach-Object { try { if ($_.Handle -ne [IntPtr]::Zero) { [Win32.MemTrim]::EmptyWorkingSet($_.Handle) | Out-Null } } catch {} }; Start-Sleep -Seconds 1; [GC]::Collect(); [GC]::WaitForPendingFinalizers(); $after = (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB; $diff = [math]::Round($after - $before, 2); Write-Host ('Free RAM Sesudah : ' + [math]::Round($after, 2) + ' GB') -ForegroundColor Green; Write-Host ('Selisih Free RAM : ' + $(if ($diff -ge 0) { '+' + $diff } else { $diff }) + ' GB') -ForegroundColor Yellow"
echo.
pause
goto MENU

:EXIT_APP
endlocal
exit /b 0