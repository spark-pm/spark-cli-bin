# SPARK CLI Installation Script for Windows
# Installs the pre-built SPARK CLI binary globally on your system
# No runtime dependencies required!

param(
    [string]$InstallDir = "$env:LOCALAPPDATA\Programs\spark"
)

$ErrorActionPreference = "Stop"

Write-Host "🚀 Installing SPARK CLI..." -ForegroundColor Cyan

# Detect architecture
$arch = if ([Environment]::Is64BitOperatingSystem) { "x64" } else { 
    Write-Host "❌ 32-bit Windows is not supported" -ForegroundColor Red
    Write-Host "📥 Please use a 64-bit Windows system" -ForegroundColor Yellow
    exit 1
}

# Download binary from GitHub releases
$binaryName = "spark-windows-$arch.exe"
$downloadUrl = "https://github.com/spark-pm/spark-cli-bin/releases/latest/download/$binaryName"

Write-Host "📥 Downloading $binaryName..." -ForegroundColor Yellow

# Create installation directory
if (!(Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
}

# Download with progress
$sparkPath = Join-Path $InstallDir "spark.exe"
try {
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($downloadUrl, $sparkPath)
    $webClient.Dispose()
} catch {
    Write-Host "❌ Download failed: $_" -ForegroundColor Red
    Write-Host "📥 Please download manually from: https://releases.sparkpm.dev" -ForegroundColor Yellow
    exit 1
}

if (!(Test-Path $sparkPath) -or (Get-Item $sparkPath).Length -eq 0) {
    Write-Host "❌ Download failed or file is empty!" -ForegroundColor Red
    Write-Host "📥 Please download manually from: https://releases.sparkpm.dev" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Downloaded successfully" -ForegroundColor Green

# Add to PATH if not already there
$currentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if ($currentPath -notlike "*$InstallDir*") {
    Write-Host "📦 Adding to PATH..." -ForegroundColor Yellow
    $newPath = "$currentPath;$InstallDir"
    [Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
    $env:PATH = "$env:PATH;$InstallDir"
    Write-Host "✅ Added to PATH (restart terminal for global effect)" -ForegroundColor Green
} else {
    Write-Host "✅ Already in PATH" -ForegroundColor Green
}

# Verify installation
Write-Host "🔍 Verifying installation..." -ForegroundColor Yellow

# Test if spark is accessible
$sparkExe = Join-Path $InstallDir "spark.exe"
if (Test-Path $sparkExe) {
    try {
        $version = & $sparkExe --version 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ SPARK CLI installed successfully!" -ForegroundColor Green
            Write-Host "🎉 Version: $version" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "🚀 Quick start:" -ForegroundColor Cyan
            Write-Host "   spark init     # Initialize a workspace" -ForegroundColor White
            Write-Host "   spark --help   # See all commands" -ForegroundColor White
            Write-Host ""
            Write-Host "💡 If 'spark' command is not found, restart your terminal or run:" -ForegroundColor Yellow
            Write-Host "   $sparkExe" -ForegroundColor White
        } else {
            throw "Command failed"
        }
    } catch {
        Write-Host "⚠️  Installation completed but verification failed" -ForegroundColor Yellow
        Write-Host "📍 Binary installed at: $sparkExe" -ForegroundColor White
        Write-Host "🔧 Try running: $sparkExe --version" -ForegroundColor White
    }
} else {
    Write-Host "❌ Installation failed. Binary not found at expected location." -ForegroundColor Red
    Write-Host "📥 Please try manual installation from: https://releases.sparkpm.dev" -ForegroundColor Yellow
    exit 1
}