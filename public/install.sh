#!/bin/bash

# SPARK CLI Installation Script
# Installs the pre-built SPARK CLI binary globally on your system
# No runtime dependencies required!
#
# Usage:
#   curl -fsSL https://cli.sparkpm.dev/install.sh | bash
#   curl -fsSL https://cli.sparkpm.dev/install.sh | bash -s -- --beta
#   curl -fsSL https://cli.sparkpm.dev/install.sh | bash -s -- --latest

set -e

# Parse arguments
RELEASE_TYPE="auto"
for arg in "$@"; do
    case $arg in
        --beta)
            RELEASE_TYPE="beta"
            shift
            ;;
        --latest)
            RELEASE_TYPE="latest"
            shift
            ;;
        *)
            echo "❌ Unknown argument: $arg"
            echo "Usage: $0 [--latest|--beta]"
            exit 1
            ;;
    esac
done

echo "🚀 Installing SPARK CLI..."

# Detect architecture
ARCH=$(uname -m)
OS=$(uname -s | tr '[:upper:]' '[:lower:]')

if [ "$ARCH" = "x86_64" ]; then
    ARCH="x64"
elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    ARCH="arm64"
else
    echo "❌ Unsupported architecture: $ARCH"
    echo "📥 Please download manually from: https://cli.sparkpm.dev"
    exit 1
fi

if [ "$OS" != "linux" ] && [ "$OS" != "darwin" ]; then
    echo "❌ Unsupported OS: $OS"
    echo "📥 Please download manually from: https://cli.sparkpm.dev"
    exit 1
fi

# Get appropriate release based on type
echo "🔍 Finding appropriate release..."

if [ "$RELEASE_TYPE" = "latest" ]; then
    # Get latest non-prerelease
    echo "🎯 Looking for latest stable release..."
    LATEST_TAG=$(curl -s https://api.github.com/repos/spark-pm/spark-cli-bin/releases | grep -A5 '"prerelease": false' | grep '"tag_name"' | head -1 | sed 's/.*"tag_name": *"//;s/".*//')
    
    if [ -z "$LATEST_TAG" ]; then
        echo "⚠️  No stable releases found, falling back to latest beta..."
        RELEASE_TYPE="beta"
    fi
fi

if [ "$RELEASE_TYPE" = "beta" ] || [ "$RELEASE_TYPE" = "auto" ]; then
    # Get latest release (including prereleases)
    echo "🧪 Looking for latest beta release..."
    LATEST_TAG=$(curl -s https://api.github.com/repos/spark-pm/spark-cli-bin/releases | grep -o '"tag_name": *"[^"]*"' | head -1 | sed 's/"tag_name": *"//;s/"//')
fi

if [ -z "$LATEST_TAG" ]; then
    echo "❌ Could not find any releases!"
    echo "📥 Please download manually from: https://cli.sparkpm.dev"
    exit 1
fi

echo "📦 Selected release: $LATEST_TAG"

# Download binary from GitHub releases
BINARY_NAME="spark-$OS-$ARCH"
DOWNLOAD_URL="https://github.com/spark-pm/spark-cli-bin/releases/download/$LATEST_TAG/$BINARY_NAME"

echo "📥 Downloading $BINARY_NAME..."

# Create temp directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Download with curl (fallback to wget)
if command -v curl &> /dev/null; then
    curl -fsSL "$DOWNLOAD_URL" -o spark
elif command -v wget &> /dev/null; then
    wget -q "$DOWNLOAD_URL" -O spark
else
    echo "❌ Neither curl nor wget found!"
    echo "📥 Please install curl or wget, or download manually from:"
    echo "   https://cli.sparkpm.dev"
    exit 1
fi

if [ ! -f "spark" ] || [ ! -s "spark" ]; then
    echo "❌ Download failed!"
    echo "📥 Please download manually from: https://cli.sparkpm.dev"
    exit 1
fi

echo "✅ Downloaded successfully"

# Install the binary globally
echo "📦 Installing binary to /usr/local/bin..."

# Handle case where binary is currently running
if [ -f "/usr/local/bin/spark" ]; then
    echo "🔄 Existing installation detected, attempting to replace..."
    
    # Try to stop any running processes (optional, but helpful)
    sudo pkill -f "spark" 2>/dev/null || true
    
    # Remove existing binary first
    sudo rm -f /usr/local/bin/spark 2>/dev/null || {
        echo "⚠️  Cannot remove existing binary (may be in use)"
        echo "💡 Please stop any running SPARK processes and try again"
        echo "   Or run: sudo pkill -f spark && sudo rm /usr/local/bin/spark"
        cd /
        rm -rf "$TEMP_DIR"
        exit 1
    }
fi

sudo cp spark /usr/local/bin/spark
sudo chmod +x /usr/local/bin/spark

# Cleanup temp directory
cd /
rm -rf "$TEMP_DIR"

# Verify installation
if command -v spark &> /dev/null; then
    echo "✅ SPARK CLI installed successfully!"
    echo "🎉 Version: $(spark --version)"
    echo ""
    echo "🚀 Quick start:"
    echo "   spark init     # Initialize a workspace"
    echo "   spark --help   # See all commands"
else
    echo "❌ Installation failed. Please try manual installation:"
    echo "   1. bun run build"
    echo "   2. npm install -g ."
    exit 1
fi