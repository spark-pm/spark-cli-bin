#!/bin/bash

# SPARK CLI Installation Script
# Installs the pre-built SPARK CLI binary globally on your system
# No runtime dependencies required!

set -e

echo "🚀 Installing SPARK CLI..."

# Check if we have a pre-built binary
if [ -f "dist/spark" ]; then
    echo "✅ Found pre-built binary"
elif [ -f "spark" ]; then
    echo "✅ Found binary in current directory"
    mkdir -p dist
    cp spark dist/spark
else
    echo "📥 No local binary found, downloading from GitHub..."
    
    # Detect architecture
    ARCH=$(uname -m)
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    
    if [ "$ARCH" = "x86_64" ]; then
        ARCH="x64"
    elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
        ARCH="arm64"
    else
        echo "❌ Unsupported architecture: $ARCH"
        echo "📥 Please download manually from: https://releases.sparkpm.dev"
        exit 1
    fi
    
    if [ "$OS" != "linux" ] && [ "$OS" != "darwin" ]; then
        echo "❌ Unsupported OS: $OS"
        echo "📥 Please download manually from: https://releases.sparkpm.dev"
        exit 1
    fi
    
    # Download binary from GitHub releases
    BINARY_NAME="spark-$OS-$ARCH"
    DOWNLOAD_URL="https://github.com/spark-pm/spark-cli-bin/releases/latest/download/$BINARY_NAME"
    
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
        echo "   https://releases.sparkpm.dev"
        exit 1
    fi
    
    if [ ! -f "spark" ] || [ ! -s "spark" ]; then
        echo "❌ Download failed!"
        echo "📥 Please download manually from: https://releases.sparkpm.dev"
        exit 1
    fi
    
    # Move to dist directory for the install process
    mkdir -p "$OLDPWD/dist"
    mv spark "$OLDPWD/dist/spark"
    cd "$OLDPWD"
    
    # Cleanup
    rm -rf "$TEMP_DIR"
    
    echo "✅ Downloaded successfully"
fi

# Install the binary globally
echo "📦 Installing binary to /usr/local/bin..."
sudo cp dist/spark /usr/local/bin/spark
sudo chmod +x /usr/local/bin/spark

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