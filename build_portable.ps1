# build_portable.ps1
# Packages the latest Flutter Windows release build into a single portable .exe
# Usage: right-click -> "Run with PowerShell"  (or: powershell -ExecutionPolicy Bypass -File build_portable.ps1)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ProjectRoot = $PSScriptRoot
$ReleaseDir  = Join-Path $ProjectRoot "build\windows\x64\runner\Release"
$OutExe      = Join-Path $ProjectRoot "test_planner_portable.exe"
$Stage       = Join-Path $ProjectRoot "_sfx_stage"
$Csc         = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe"
$RefDir      = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319"

# ── 1. Verify release build exists ──────────────────────────────────────────
if (-not (Test-Path (Join-Path $ReleaseDir "test_planner.exe"))) {
    Write-Error "Release build not found at '$ReleaseDir'. Run 'flutter build windows --release' first."
    exit 1
}

# ── 2. Prepare staging area ──────────────────────────────────────────────────
Write-Host "Preparing staging area..."
Remove-Item $Stage -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory $Stage | Out-Null

# ── 3. Zip the Release folder ────────────────────────────────────────────────
Write-Host "Zipping Release build..."
$ZipPath = Join-Path $Stage "Release.zip"
Compress-Archive -Path (Join-Path $ReleaseDir "*") -DestinationPath $ZipPath -Force
Write-Host "  Zip size: $([math]::Round((Get-Item $ZipPath).Length/1MB,2)) MB"

# ── 4. Write C# launcher source ──────────────────────────────────────────────
Write-Host "Writing launcher source..."
$CsPath = Join-Path $Stage "launcher.cs"
@'
using System;
using System.IO;
using System.IO.Compression;
using System.Diagnostics;
using System.Reflection;

class Program {
    [STAThread]
    static void Main() {
        string dest = Path.Combine(Path.GetTempPath(), "TestPlannerApp");
        string exe  = Path.Combine(dest, "test_planner.exe");
        // Always re-extract to ensure the latest version is used.
        if (Directory.Exists(dest)) {
            try { Directory.Delete(dest, true); } catch {}
        }
        Directory.CreateDirectory(dest);
        string tmp = Path.GetTempFileName();
        try {
            var asm = Assembly.GetExecutingAssembly();
            using (var src = asm.GetManifestResourceStream("Release.zip"))
            using (var dst = File.Create(tmp)) { src.CopyTo(dst); }
            ZipFile.ExtractToDirectory(tmp, dest);
        } finally {
            if (File.Exists(tmp)) File.Delete(tmp);
        }
        Process.Start(new ProcessStartInfo(exe) { UseShellExecute = true });
    }
}
'@ | Set-Content $CsPath -Encoding UTF8

# ── 5. Compile into a single portable exe ───────────────────────────────────
Write-Host "Compiling portable exe..."
Remove-Item $OutExe -Force -ErrorAction SilentlyContinue

$cscArgs = @(
    "/nologo", "/optimize+", "/target:winexe",
    "/out:$OutExe",
    "/res:$ZipPath,Release.zip",
    "/reference:$RefDir\System.IO.Compression.dll",
    "/reference:$RefDir\System.IO.Compression.FileSystem.dll",
    $CsPath
)
& $Csc @cscArgs 2>&1 | Where-Object { $_ -notmatch "^$" } | ForEach-Object { Write-Host "  csc: $_" }

# ── 6. Clean up staging area ─────────────────────────────────────────────────
Remove-Item $Stage -Recurse -Force -ErrorAction SilentlyContinue

# ── 7. Report result ─────────────────────────────────────────────────────────
$f = Get-Item $OutExe -ErrorAction SilentlyContinue
if ($f) {
    Write-Host ""
    Write-Host "Done!  $($f.Name)  ($([math]::Round($f.Length/1MB,2)) MB)"
    Write-Host "       $($f.FullName)"
} else {
    Write-Error "Build failed - output exe not found."
    exit 1
}
