# SPARK CLI - Complete Command Reference

**Comprehensive documentation for the SPARK CLI tool**

> This is the complete reference for all SPARK CLI commands, options, and features. For installation instructions, see the [main README](README.md).

## Table of Contents

- [Getting Started](#getting-started)
- [Global Options](#global-options)
- [Workspace Management](#workspace-management)
- [Authentication](#authentication)
- [Task Management](#task-management)
- [Backlog Management](#backlog-management)
- [Board Operations](#board-operations)
- [OKR Management](#okr-management)
- [Tag Management](#tag-management)
- [Proposal System](#proposal-system)
- [Configuration](#configuration)
- [AI Integration](#ai-integration)
- [Examples](#examples)

## Getting Started

### Installation Verification

```bash
# Check if SPARK CLI is installed
spark --version

# Get general help
spark --help

# Get help for specific commands
spark <command> --help
```

### First Time Setup

```bash
# Initialize your first SPARK workspace
spark init

# This will:
# - Create workspace configuration
# - Set up authentication
# - Guide you through OKR creation
# - Create your first SPARK board
```

## Global Options

Available with all commands:

```bash
--help, -h          Show help information
--version, -v       Show version information
--json              Output in JSON format
--yaml              Output in YAML format
--no-color          Disable colored output
--verbose           Enable verbose logging
--config <path>     Use custom config file
--workspace <id>    Use specific workspace
```

## Workspace Management

### `spark init`

Initialize a new SPARK workspace.

```bash
spark init                                    # Interactive setup
spark init --name "My Team"                   # Set workspace name
spark init --skip-okrs                        # Skip OKR setup
spark init --server "https://my-server.com"   # Custom server URL
```

**Options:**
- `--name <name>` - Set workspace name
- `--skip-okrs` - Skip OKR creation during setup
- `--server <url>` - Custom server URL

### `spark workspace`

Manage workspace settings and members.

```bash
spark workspace show                          # Show workspace details
spark workspace edit                          # Edit workspace settings
spark workspace members                       # List workspace members
spark workspace invite                        # Invite new members
spark workspace settings                      # Configure workspace settings
```

**Subcommands:**
- `show` - Display workspace information
- `edit` - Modify workspace settings
- `members` - Manage workspace members
- `invite` - Send member invitations
- `settings` - Configure workspace options

## Authentication

### `spark auth login`

Login using OAuth device flow.

```bash
spark auth login                              # Use default server
spark auth login --server <url>              # Custom server URL
spark auth login --workspace <id>            # Login to specific workspace
```

**Options:**
- `--server <url>` - Custom server URL
- `--workspace <id>` - Target workspace ID

### `spark auth register`

Register a new account.

```bash
spark auth register                           # Interactive registration
spark auth register --name "John Doe"        # Set display name
spark auth register --email "john@example.com" # Set email
spark auth register --json                   # Register with JSON input
```

**Options:**
- `--name <name>` - Display name
- `--email <email>` - Email address
- `--json` - Accept JSON input

### `spark auth status`

Check authentication status.

```bash
spark auth status                             # Current auth status
spark auth status --json                     # Structured output
spark auth status --verbose                  # Detailed information
```

**Options:**
- `--json` - JSON output format
- `--verbose` - Show detailed information

### `spark auth logout`

Logout from server.

```bash
spark auth logout                             # Logout from current workspace
spark auth logout --all                      # Logout from all workspaces
```

**Options:**
- `--all` - Logout from all workspaces

### `spark auth refresh`

Refresh authentication tokens.

```bash
spark auth refresh                            # Refresh current tokens
```

## Task Management

### `spark task create`

Create a new task.

```bash
spark task create "Fix login bug"                              # Simple task
spark task create "Add feature" --description "Details here"   # With description
spark task create "Task" --tags "bug,urgent"                  # With tags
spark task create "Task" --assignee "john"                    # With assignee
spark task create --json                                      # JSON input
spark task create --yaml                                      # YAML input
spark task create --editor                                    # External editor
spark task create --file tasks.json                           # From file
```

**Options:**
- `--description <text>` - Task description
- `--tags <tags>` - Comma-separated tags
- `--assignee <user>` - Assign to user
- `--json` - Accept JSON input
- `--yaml` - Accept YAML input
- `--editor` - Use external editor
- `--file <path>` - Create from file

**JSON Format:**
```json
{
  "title": "Task title",
  "description": "Task description",
  "tags": ["tag1", "tag2"],
  "assignee": "username",
  "priority": "high|medium|low"
}
```

### `spark task edit`

Edit an existing task.

```bash
spark task edit <taskId>                      # Interactive edit
spark task edit <taskId> --editor             # External editor
spark task edit <taskId> --json               # JSON input
spark task edit <taskId> --yaml               # YAML input
```

**Options:**
- `--editor` - Use external editor
- `--json` - Accept JSON input
- `--yaml` - Accept YAML input

### `spark task assign`

Assign tasks to team members.

```bash
spark task assign <taskId> --to "john"        # Assign to user
spark task assign <taskId> --unassign         # Remove assignment
```

**Options:**
- `--to <user>` - Assign to specific user
- `--unassign` - Remove current assignment

### `spark task review`

Manage task reviews.

```bash
spark task review <taskId>                    # Start review process
spark task review <taskId> --approve          # Approve task
spark task review <taskId> --reject           # Reject task
spark task review <taskId> --comment "text"   # Add review comment
```

**Options:**
- `--approve` - Approve the task
- `--reject` - Reject the task
- `--comment <text>` - Add review comment

### `spark task pull`

Pull an available task from backlog.

```bash
spark task pull                               # Interactive selection
spark task pull --assignee "john"            # Assign to specific user
spark task pull --tag "bug"                  # Pull tasks with specific tag
spark task pull --priority "high"            # Pull high priority tasks
```

**Options:**
- `--assignee <user>` - Assign to specific user
- `--tag <tag>` - Filter by tag
- `--priority <level>` - Filter by priority level

### `spark task list`

List tasks with advanced filtering.

```bash
spark task list                               # All tasks
spark task list --status backlog             # Filter by status
spark task list --assignee "jane"            # Filter by assignee
spark task list --tag "bug"                  # Filter by tag
spark task list --priority "high"            # Filter by priority
spark task list --json                       # JSON output
spark task list --sort "priority"            # Sort by field
spark task list --limit 10                   # Limit results
```

**Options:**
- `--status <status>` - Filter by status (backlog, in_progress, review, done)
- `--assignee <user>` - Filter by assignee
- `--tag <tag>` - Filter by tag
- `--priority <level>` - Filter by priority
- `--sort <field>` - Sort by field (priority, created, updated)
- `--limit <number>` - Limit number of results
- `--json` - JSON output format

### `spark task move`

Move task between columns.

```bash
spark task move <taskId>                      # Move to next column
spark task move <taskId> --to done            # Move to specific column
```

**Options:**
- `--to <column>` - Move to specific column (backlog, in_progress, review, done)

### `spark task delete`

Delete a task.

```bash
spark task delete <taskId>                    # Delete with confirmation
spark task delete <taskId> --force           # Force delete without confirmation
```

**Options:**
- `--force` - Skip confirmation prompt

## Backlog Management

### `spark backlog`

Browse and manage the backlog.

```bash
spark backlog                                 # View backlog
spark backlog --tag "bug"                    # Filter by tag
spark backlog --assignee "john"              # Filter by assignee
spark backlog --priority "high"              # Filter by priority
spark backlog --json                         # JSON output
spark backlog --limit 10                     # Limit results
spark backlog --sort "priority"              # Sort by field
```

**Options:**
- `--tag <tag>` - Filter by tag
- `--assignee <user>` - Filter by assignee
- `--priority <level>` - Filter by priority
- `--limit <number>` - Limit results
- `--sort <field>` - Sort by field
- `--json` - JSON output format

## Board Operations

### `spark board`

View and manage the SPARK board.

```bash
spark board                                   # View current board
spark board --refresh                         # Refresh from server
spark board --json                            # JSON output
spark board --filter "tag:bug"               # Filter by tag
spark board --assignee "john"                # Filter by assignee
spark board --no-colors                      # Disable colors
```

**Options:**
- `--refresh` - Refresh data from server
- `--json` - JSON output format
- `--filter <filter>` - Apply filter (tag:name, assignee:user)
- `--assignee <user>` - Filter by assignee
- `--no-colors` - Disable colored output

## OKR Management

### `spark okr create`

Create quarterly OKRs with multiple input methods.

```bash
spark okr create                              # Interactive creation
spark okr create --editor                     # External editor
spark okr create --json                       # JSON input
spark okr create --yaml                       # YAML input
spark okr create --file okrs.json             # From file
```

**Options:**
- `--editor` - Use external editor
- `--json` - Accept JSON input
- `--yaml` - Accept YAML input
- `--file <path>` - Create from file

**JSON Format:**
```json
{
  "objective": "Improve user experience",
  "key_results": [
    {
      "title": "Reduce load time by 50%",
      "target": 2.5,
      "unit": "seconds"
    },
    {
      "title": "Increase user satisfaction to 90%",
      "target": 90,
      "unit": "percent"
    }
  ]
}
```

### `spark okr edit`

Edit existing OKRs.

```bash
spark okr edit <okrId>                        # Interactive edit
spark okr edit <okrId> --editor               # External editor
spark okr edit <okrId> --json                 # JSON input
spark okr edit <okrId> --yaml                 # YAML input
```

**Options:**
- `--editor` - Use external editor
- `--json` - Accept JSON input
- `--yaml` - Accept YAML input

### `spark okr list`

List all OKRs with filtering.

```bash
spark okr list                                # All OKRs
spark okr list --quarter Q1                  # Filter by quarter
spark okr list --status active               # Filter by status
spark okr list --json                        # JSON output
```

**Options:**
- `--quarter <quarter>` - Filter by quarter (Q1, Q2, Q3, Q4)
- `--status <status>` - Filter by status (active, completed, archived)
- `--json` - JSON output format

### `spark okr status`

View OKR progress with visual indicators.

```bash
spark okr status                              # All OKRs progress
spark okr status <okrId>                      # Specific OKR progress
spark okr status --json                       # Structured output
```

**Options:**
- `--json` - JSON output format

### `spark okr update`

Update OKR progress.

```bash
spark okr update <okrId>                      # Interactive update
spark okr update <okrId> --progress 75       # Set progress percentage
spark okr update <okrId> --value 85          # Set current value
```

**Options:**
- `--progress <percentage>` - Set progress percentage
- `--value <number>` - Set current value

## Tag Management

### `spark tags`

Manage task tags.

```bash
spark tags list                               # List all tags
spark tags create "bug"                       # Create new tag
spark tags delete "old-tag"                   # Delete tag
spark tags rename "old" "new"                 # Rename tag
spark tags stats                              # Show tag statistics
```

**Subcommands:**
- `list` - List all tags
- `create <name>` - Create new tag
- `delete <name>` - Delete tag
- `rename <old> <new>` - Rename tag
- `stats` - Show tag usage statistics

## Proposal System

### `spark proposal`

Manage team proposals.

```bash
spark proposal create                         # Create new proposal
spark proposal list                           # List all proposals
spark proposal show <proposalId>             # Show proposal details
spark proposal approve <proposalId>          # Approve proposal
spark proposal reject <proposalId>           # Reject proposal
spark proposal comment <proposalId> "text"   # Add comment
```

**Subcommands:**
- `create` - Create new proposal
- `list` - List all proposals
- `show <id>` - Show proposal details
- `approve <id>` - Approve proposal
- `reject <id>` - Reject proposal
- `comment <id> <text>` - Add comment

## Configuration

### Configuration Files

```
.spark/
├── config.json             # Team/workspace config (committed)
└── local/
    ├── config.json         # User auth config (gitignored)
    ├── cache/              # Command cache (gitignored)
    └── logs/               # Command logs (gitignored)
```

### Configuration Hierarchy

1. **Command-line arguments** (highest priority)
2. **Environment variables**
3. **Local config** (`.spark/local/config.json`)
4. **Workspace config** (`.spark/config.json`)
5. **Global config** (`~/.spark/config.json`)
6. **Default values** (lowest priority)

### Environment Variables

```bash
export SPARK_SERVER_URL="https://my-server.com"    # Override server URL
export SPARK_CONFIG_DIR="/custom/path"             # Custom config directory
export SPARK_WORKSPACE_ID="workspace-123"          # Override workspace ID
export SPARK_AUTH_TOKEN="token-here"               # Override auth token
export SPARK_EDITOR="vim"                          # Override default editor
export SPARK_NO_COLOR=1                            # Disable colored output
export SPARK_LOG_LEVEL="debug"                     # Set logging level
export SPARK_CACHE_TTL=300                         # Cache time-to-live
```

### Configuration Options

```json
{
  "server": {
    "url": "https://api.sparkpm.dev",
    "timeout": 30000,
    "retry": 3
  },
  "ui": {
    "colors": true,
    "table_style": "grid",
    "max_width": 120,
    "pager": "auto"
  },
  "editor": {
    "command": "$EDITOR",
    "temp_dir": "/tmp/spark"
  },
  "cache": {
    "enabled": true,
    "ttl": 300
  }
}
```

## AI Integration

SPARK CLI is designed for seamless AI integration:

### JSON Input/Output

```bash
# Create task from JSON
echo '{"title":"Fix bug","tags":["bug","urgent"]}' | spark task create --json

# Get board as JSON
spark board --json

# Process tasks with jq
spark task list --json | jq '.[] | select(.tags[] == "bug")'
```

### YAML Input/Output

```bash
# Create OKR from YAML
spark okr create --yaml <<EOF
objective: "Improve performance"
key_results:
  - title: "Reduce load time"
    target: 2.0
    unit: "seconds"
EOF

# Get OKR status as YAML
spark okr status --yaml
```

### Non-Interactive Usage

```bash
# All commands support non-interactive mode
spark task create "title" --description "desc" --tags "tag1,tag2"
spark task assign task-123 --to "user"
spark okr update okr-456 --progress 75
```

### Error Handling

```bash
# Commands return appropriate exit codes
spark task create "title" || echo "Failed"

# Structured error messages
spark task create --json 2>&1 | jq '.error'
```

## Examples

### Basic Workflow

```bash
# 1. Initialize workspace
spark init --name "My Project"

# 2. Create some tasks
spark task create "Set up development environment"
spark task create "Implement user authentication" --tags "feature,auth"
spark task create "Fix login bug" --tags "bug,urgent"

# 3. View the board
spark board

# 4. Pull a task to work on
spark task pull

# 5. Move task through workflow
spark task move task-123 --to in_progress
spark task move task-123 --to review
spark task move task-123 --to done
```

### OKR Management

```bash
# Create quarterly OKRs
spark okr create --yaml <<EOF
objective: "Improve user experience"
key_results:
  - title: "Reduce page load time to under 2 seconds"
    target: 2.0
    unit: "seconds"
  - title: "Achieve 95% user satisfaction"
    target: 95
    unit: "percent"
EOF

# Track progress
spark okr status
spark okr update okr-123 --progress 60
```

### Tag Management

```bash
# Create and organize tags
spark tags create "bug"
spark tags create "feature"
spark tags create "urgent"

# Filter tasks by tags
spark task list --tag "bug"
spark backlog --tag "urgent"
```

### AI Integration Examples

```bash
# Create tasks from AI-generated JSON
cat ai_tasks.json | spark task create --json

# Get structured data for AI processing
spark board --json | ai-processor

# Batch operations
spark task list --json | jq '.[].id' | xargs -I {} spark task assign {} --to "developer"
```

### Advanced Filtering

```bash
# Complex board filtering
spark board --filter "tag:bug" --assignee "john"

# Backlog management
spark backlog --priority "high" --limit 5 --sort "created"

# Task reporting
spark task list --status done --json | jq 'length'
```

## Getting Help

- Use `spark --help` for general help
- Use `spark <command> --help` for command-specific help
- Use `--json` flag for structured output
- Use `--verbose` flag for detailed logging
- Check the [main README](README.md) for installation and getting started

---

**This documentation covers all SPARK CLI features and commands. For framework methodology, see the [SPARK Framework Guide](https://github.com/spark-pm/spark/blob/main/SPARK.md).**