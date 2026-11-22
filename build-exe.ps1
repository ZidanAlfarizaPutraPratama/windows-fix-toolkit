$batPath = Join-Path $PWD "windows-fix-toolkit.bat"
$icoPath = Join-Path $PWD "assets\app.ico"
$exePath = Join-Path $PWD "windows-fix-toolkit.exe"

if (-not (Test-Path $batPath)) { Write-Host "File windows-fix-toolkit.bat tidak ditemukan!" -ForegroundColor Red; exit 1 }
if (-not (Test-Path $icoPath)) { Write-Host "File assets\app.ico tidak ditemukan! Jalankan make-icon.ps1 dulu." -ForegroundColor Red; exit 1 }

$cscPath = @(
    "$env:WINDIR\Microsoft.NET\Framework64\v4.0.30319\csc.exe",
    "$env:WINDIR\Microsoft.NET\Framework\v4.0.30319\csc.exe"
) | Where-Object { Test-Path $_ } | Select-Object -First 1

if (-not $cscPath) {
    Write-Host "Compiler csc.exe (.NET Framework 4.x) tidak ditemukan." -ForegroundColor Red
    exit 1
}

$batContent = Get-Content -Path $batPath -Raw -Encoding UTF8
$verMatch = [regex]::Match($batContent, 'APP_VERSION=([0-9]+\.[0-9]+\.[0-9]+)')
$appVer = if ($verMatch.Success) { $verMatch.Groups[1].Value } else { "1.0.0" }
$batBase64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($batContent))
$tempCs = Join-Path $env:TEMP ("WinFixBuild_" + [Guid]::NewGuid().ToString("N") + ".cs")

$csCode = @"
using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Text;

[assembly: AssemblyTitle("windows-fix-toolkit")]
[assembly: AssemblyDescription("Windows Repair, Maintenance & Performance Toolkit")]
[assembly: AssemblyProduct("windows-fix-toolkit")]
[assembly: AssemblyCopyright("Copyright (c) 2026 Zidan Alfariza Putra Pratama")]
[assembly: AssemblyVersion("$appVer.0")]
[assembly: AssemblyFileVersion("$appVer.0")]

class Program {
    static void Main() {
        string exeFullPath = Assembly.GetExecutingAssembly().Location;
        string tempBat = Path.Combine(Path.GetTempPath(), "WinFix_" + Guid.NewGuid().ToString("N") + ".bat");
        try {
            byte[] batBytes = Convert.FromBase64String("$batBase64");
            File.WriteAllBytes(tempBat, batBytes);

            ProcessStartInfo psi = new ProcessStartInfo("cmd.exe", "/c \"\"" + tempBat + "\"\"");
            psi.UseShellExecute = false;
            psi.EnvironmentVariables["WINFIX_EXE_PATH"] = exeFullPath;

            Process p = Process.Start(psi);
            p.WaitForExit();
        } finally {
            if (File.Exists(tempBat)) { try { File.Delete(tempBat); } catch {} }
        }
    }
}
"@

try {
    Set-Content -Path $tempCs -Value $csCode -Encoding UTF8
    & $cscPath /nologo /target:exe /optimize+ /win32icon:"$icoPath" /out:"$exePath" "$tempCs"
    if ($LASTEXITCODE -eq 0 -and (Test-Path $exePath)) {
        Write-Host "Sukses! windows-fix-toolkit.exe (v$appVer) berhasil dibuat." -ForegroundColor Green
    } else {
        Write-Host "Gagal mengompilasi windows-fix-toolkit.exe." -ForegroundColor Red
        exit 1
    }
} finally {
    if (Test-Path $tempCs) { Remove-Item -Path $tempCs -Force -ErrorAction SilentlyContinue }
}