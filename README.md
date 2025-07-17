# SPARK CLI - Official Release Distribution

**The definitive companion tool for the SPARK Framework**

![SPARK CLI - Terminal-based project management for the AI era](https://img.shields.io/badge/SPARK-CLI-cyan?style=for-the-badge)

> **SPARK CLI is the living proof that the SPARK Framework works.** While you can use SPARK Framework anywhere with any tools, SPARK CLI demonstrates its full power through revolutionary terminal-based project management that's built for human + AI collaboration.

## 🚀 What is SPARK CLI?

SPARK CLI is the **definitive companion tool** for the [SPARK Framework](https://github.com/spark-pm/spark) - a lightweight project management methodology for high-velocity teams. This CLI tool:

- **Proves the Framework**: Living demonstration of SPARK Framework effectiveness
- **Enables Terminal PM**: Revolutionary project management directly in your terminal
- **Built for AI Era**: Designed for seamless human + AI collaboration workflows
- **Eases Adoption**: Makes implementing SPARK Framework effortless for any team

## 🆚 SPARK CLI vs. Taskmaster AI

Many people confuse SPARK CLI with Taskmaster AI. Here's the key difference:

| Aspect | SPARK CLI | Taskmaster AI |
|--------|-----------|---------------|
| **Purpose** | Framework implementation & team collaboration | AI task automation & individual productivity |
| **Focus** | Structured project management methodology | AI-driven task execution |
| **Use Case** | Terminal-based PM with human + AI workflows | AI-powered task completion |
| **Target** | Development teams using SPARK Framework | Individual developers wanting AI assistance |
| **Methodology** | Implements proven SPARK Framework principles | AI-first automation approach |
| **Collaboration** | Multi-user workspaces with role-based access | Individual productivity enhancement |
| **Output** | Structured project data (JSON/YAML) | Task execution and automation |

**TL;DR**: SPARK CLI implements a project management framework. Taskmaster AI automates individual tasks. Different tools for different purposes.

## 📦 Installation

### Quick Install (Recommended)

```bash
curl -fsSL https://cli.sparkpm.dev/install.sh | bash
```

### Manual Install

```bash
# Download for your platform
curl -L https://cli.sparkpm.dev/latest/spark-linux-x64 -o spark
sudo mv spark /usr/local/bin/spark
sudo chmod +x /usr/local/bin/spark
```

### Platform Support

- **Linux**: x64, ARM64
- **macOS**: Intel, Apple Silicon
- **Windows**: Coming soon

### Verify Installation

```bash
spark --version
spark --help
```

## 🎯 Quick Start - Experience SPARK Framework

### 1. Initialize Your First SPARK Workspace

```bash
spark init
```

This command starts the SPARK Framework adoption journey:
- Creates workspace configuration
- Sets up team collaboration
- Guides through OKR creation
- Establishes your first SPARK board

### 2. Essential Commands

```bash
# Get help for any command
spark --help
spark task --help

# View your SPARK board (Kanban-style)
spark board

# Create your first task
spark task create "Set up development environment"

# Pull a task to work on (SPARK's pull-based workflow)
spark task pull

# Track quarterly progress
spark okr status
```

### 3. AI-Friendly Features

SPARK CLI is built for the AI era with structured input/output:

```bash
# JSON output for AI processing
spark board --json

# Create tasks from structured data
echo '{"title":"AI-generated task","tags":["ai","feature"]}' | spark task create --json

# Batch operations for AI agents
spark task list --json | jq '.[] | select(.status == "backlog")'
```

## 🌟 Why SPARK CLI Proves the Framework Works

### 1. **Real-World Implementation**
- We built SPARK CLI using SPARK Framework itself
- Every feature demonstrates framework principles in action
- Continuous dogfooding ensures methodology effectiveness

### 2. **Terminal-Native Project Management**
- Revolutionary approach to PM directly in developer environment
- No context switching between tools
- Integrates seamlessly with development workflows

### 3. **Built for Human + AI Collaboration**
- Structured data formats (JSON/YAML) for AI integration
- Non-interactive modes for automated workflows
- Clear APIs for AI agents to interact with project data

### 4. **Scales with Your Team**
- Individual developer productivity
- Small team collaboration (1-10 people)
- Growing team coordination (10-30 people)

## 🛠️ Core SPARK Framework Features

SPARK CLI implements the complete SPARK methodology:

- **📋 4-Column Board**: Backlog → In Progress → Review → Done
- **🎯 OKR Management**: Quarterly objectives with measurable key results
- **🔄 Pull-Based Workflow**: Team members pull work when ready (no push)
- **📊 Progress Tracking**: Visual indicators and progress bars
- **👥 Team Collaboration**: Multi-user workspaces with role-based access
- **🏷️ Tag Organization**: Flexible task categorization and filtering
- **📝 Proposal System**: Structured decision-making process

## 🤖 Perfect for AI-Assisted Development

SPARK CLI is specifically designed for the AI era:

### For AI Agents
- **Structured I/O**: JSON/YAML input and output
- **Predictable APIs**: Consistent command patterns
- **Error Handling**: Machine-readable error messages
- **Batch Operations**: Efficient bulk processing

### For Human Developers
- **Terminal Integration**: Works in your natural environment
- **Rich UI**: Colors, tables, progress bars, and animations
- **Interactive Prompts**: Guided workflows for complex operations
- **External Editor**: Support for your preferred editor

## 🔗 Resources

- **📖 SPARK Framework Documentation**: [Main Repository](https://github.com/spark-pm/spark)
- **🎓 Framework Guide**: [Complete implementation methodology](https://github.com/spark-pm/spark/blob/main/SPARK.md)
- **📚 CLI Documentation**: [Comprehensive command reference](CLI-DOCUMENTATION.md)
- **💬 Community Support**: GitHub Issues and Discussions

## 📞 Support

### For SPARK CLI Issues
- **🐛 Bug Reports**: [GitHub Issues](https://github.com/spark-pm/spark-releases/issues)
- **💡 Feature Requests**: [GitHub Issues](https://github.com/spark-pm/spark-releases/issues)
- **💬 Community**: [GitHub Discussions](https://github.com/spark-pm/spark-releases/discussions)

### For SPARK Framework Questions
- **📖 Documentation**: [SPARK Framework Repository](https://github.com/spark-pm/spark)
- **🎓 Implementation Help**: Framework guides and tutorials
- **👥 Community**: Framework-specific discussions

## 🎉 Join the Revolution

**SPARK CLI proves that revolutionary project management is possible.** 

Stop switching between tools. Stop losing context. Start managing projects where you actually work - in the terminal.

**Experience the future of project management:**

```bash
curl -fsSL https://cli.sparkpm.dev/install.sh | bash
spark init
```

---

**Built with ❤️ for high-velocity teams and AI-powered development workflows**

*SPARK CLI - Where framework meets reality*