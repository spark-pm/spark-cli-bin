# SPARK CLI Binary Distribution

Public repository for SPARK CLI binary distribution and community support, deployed at `cli.sparkpm.dev` via GitHub Pages.

## 🚀 Purpose

- **Binary Distribution**: Serves compiled SPARK CLI binaries for all platforms
- **Installation Script**: Provides the one-liner installation experience
- **Release Portal**: Public-facing release notes and download page
- **CDN Distribution**: Fast, global delivery of CLI assets

## 📁 Structure

```
spark-releases/
├── public/                        # Netlify deployment folder
│   ├── install.sh                 # One-liner installation script
│   ├── index.html                 # Release portal homepage
│   ├── latest/                    # Latest version binaries
│   │   ├── spark-linux-x64
│   │   ├── spark-linux-arm64
│   │   ├── spark-darwin-x64
│   │   └── spark-darwin-arm64
│   └── v0.1.0-beta.1/            # Version-specific releases
│       ├── spark-linux-x64
│       ├── spark-linux-arm64
│       ├── spark-darwin-x64
│       ├── spark-darwin-arm64
│       └── release-notes.html
├── netlify.toml                   # Netlify configuration
└── README.md                      # This file
```

## 🔧 Deployment Setup

### 1. GitHub Pages Configuration

1. **Repository settings** → Pages
2. **Source**: GitHub Actions
3. **Custom domain**: Configure `cli.sparkpm.dev`
4. **Automatic deployment** on push to main branch

### 2. DNS Setup

Add CNAME record:
```
cli.sparkpm.dev → spark-pm.github.io
```

### 3. SSL/Security

- GitHub Pages automatically provides SSL certificates
- HTTPS enforcement enabled by default
- Custom domain with automatic certificate provisioning

## 📦 Release Process

### Adding a New Release

1. **Build binaries** in the main CLI repository:
   ```bash
   # In spark-cli/
   bun run build  # Creates dist/spark
   ```

2. **Create version directory**:
   ```bash
   mkdir -p public/v1.0.0/
   ```

3. **Copy binaries** for each platform:
   ```bash
   # Build for each platform and copy
   cp dist/spark-linux-x64 public/v1.0.0/
   cp dist/spark-linux-arm64 public/v1.0.0/
   cp dist/spark-darwin-x64 public/v1.0.0/
   cp dist/spark-darwin-arm64 public/v1.0.0/
   ```

4. **Update latest symlinks**:
   ```bash
   # Update latest/ to point to new version
   cp public/v1.0.0/* public/latest/
   ```

5. **Create release notes**:
   ```bash
   cp public/v0.1.0-beta.1/release-notes.html public/v1.0.0/
   # Edit with new release information
   ```

6. **Update homepage** (`public/index.html`):
   - Add new release section
   - Update version numbers
   - Enable download links if ready

7. **Deploy**:
   ```bash
   git add .
   git commit -m "Release v1.0.0"
   git push origin main
   # GitHub Actions automatically deploys to Pages
   ```

### Beta Releases

For beta releases (like `v0.1.0-beta.1`):

1. Follow same process as above
2. Keep "Coming Soon" section until binaries are ready
3. Use beta badges in HTML
4. Don't update `/latest/` until stable release

## 🌐 URLs

### Primary Endpoints
- **Homepage**: `https://cli.sparkpm.dev/`
- **Install Script**: `https://cli.sparkpm.dev/install.sh`
- **Latest Binaries**: `https://cli.sparkpm.dev/latest/spark-{os}-{arch}`

### Version-Specific
- **Release Notes**: `https://cli.sparkpm.dev/v{version}/release-notes.html`
- **Version Binaries**: `https://cli.sparkpm.dev/v{version}/spark-{os}-{arch}`

### Platform Examples
- Linux x64: `https://cli.sparkpm.dev/latest/spark-linux-x64`
- macOS ARM64: `https://cli.sparkpm.dev/latest/spark-darwin-arm64`

## 🔄 Installation Flow

1. **User runs**: `curl -fsSL https://cli.sparkpm.dev/install.sh | bash`
2. **Script detects** platform (OS + architecture)
3. **Downloads binary** from `/latest/spark-{platform}`
4. **Installs** to `/usr/local/bin/spark`
5. **Verifies** installation with `spark --version`

## 📋 Maintenance

### Regular Tasks

- **Monitor usage**: Check GitHub Pages analytics and repo traffic
- **Update binaries**: Keep `/latest/` current with stable releases  
- **Security updates**: Ensure custom domain SSL remains current
- **Performance**: GitHub's CDN provides global distribution

### File Management

- **Cleanup old versions**: Remove obsolete version directories periodically
- **Binary verification**: Ensure all platform binaries are present and functional
- **Link validation**: Verify all download links work correctly

## 🛠️ Development

### Local Testing

```bash
# Serve locally for testing
cd spark-releases
python3 -m http.server 8000 --directory public
# Visit http://localhost:8000
```

### Validation Checklist

Before deploying:
- [ ] All binary files are present and executable
- [ ] Install script works locally
- [ ] Release notes are accurate and complete
- [ ] Homepage reflects current release status
- [ ] All links are functional

## 🔒 Security

- Binary integrity should be verified (consider adding checksums)
- Install script should validate downloads
- HTTPS-only distribution
- Security headers configured via Netlify

## 📞 Support

For issues with SPARK CLI:
1. **Report bugs**: Use GitHub Issues in this repository
2. **Feature requests**: Submit via GitHub Issues
3. **Installation problems**: Check Actions logs and test locally
4. **Community support**: GitHub Discussions available

For server/infrastructure issues:
1. Check GitHub Actions deployment logs
2. Verify DNS and SSL configuration  
3. Test install script across platforms

---

This infrastructure enables professional, scalable distribution of SPARK CLI while maintaining control over the release process.