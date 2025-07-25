# Integration Instructions for Dependencies Repository

## Overview
This document provides instructions for integrating the ai-sdk-provider-claude-code's dependency management approach with the existing fork-first dependency system in `/Users/kayaozkur/Documents/dev/dependencies`.

## For the Agent Working on Dependencies Repo

### Context Files to Read First
1. **This repository's approach:**
   - `/Users/kayaozkur/Documents/ai-sdk-provider-claude-code/.github/workflows/integrated-dependency-sync.yml`
   - `/Users/kayaozkur/Documents/ai-sdk-provider-claude-code/dependency-config.yml`
   - `/Users/kayaozkur/Documents/ai-sdk-provider-claude-code/docs/SYNC-AND-UPDATE.md`

2. **Existing dependencies system:**
   - `/Users/kayaozkur/Documents/dev/dependencies/README.md`
   - `/Users/kayaozkur/Documents/dev/dependencies/config/sync-config.yml`
   - `/Users/kayaozkur/Documents/dev/dependencies/scripts/fork-sync.sh`
   - `/Users/kayaozkur/Documents/dev/dependencies/scripts/fork-management.py`

### Integration Tasks

#### 1. Add ai-sdk-provider-claude-code to sync-config.yml

Add this entry to `/Users/kayaozkur/Documents/dev/dependencies/config/sync-config.yml`:

```yaml
ai-sdk-provider-claude-code:
  upstream: https://github.com/ben-vargas/ai-sdk-provider-claude-code
  fork: https://github.com/kayaozkur/proj_dep_ai-sdk-provider-claude-code
  version: latest
  install_method: npm
  tests:
    - command: "cd /Users/kayaozkur/Documents/ai-sdk-provider-claude-code && npm test"
      expected_output: "passing"
    - script: "./tests/dependency-tests/test-ai-sdk-provider-claude-code.sh"
  update_policy: "test-first"
  rollback_on_failure: true
  special_handling:
    critical_dependency: "@anthropic-ai/claude-code"
    exact_versioning: true
  notes: "AI SDK provider for Claude via Claude Code SDK - has GitHub Actions automation"
```

#### 2. Create Test Script

Create `/Users/kayaozkur/Documents/dev/dependencies/tests/dependency-tests/test-ai-sdk-provider-claude-code.sh`:

```bash
#!/usr/bin/env bash

# Test script for ai-sdk-provider-claude-code
set -euo pipefail

REPO_PATH="/Users/kayaozkur/Documents/ai-sdk-provider-claude-code"

echo "Testing ai-sdk-provider-claude-code..."

# Navigate to repo
cd "$REPO_PATH" || exit 1

# Run the integrated test suite
npm run build || exit 1
npm run typecheck || exit 1
npm test || exit 1

# Test critical dependency
CLAUDE_VERSION=$(node -p "require('./package.json').dependencies['@anthropic-ai/claude-code']")
echo "Claude Code SDK version: $CLAUDE_VERSION"

# Run local sync check
if [[ -x "./scripts/local-sync.sh" ]]; then
    echo "4" | ./scripts/local-sync.sh  # Run tests only option
fi

echo "✅ All tests passed"
```

#### 3. Enhance fork-management.py

Add special handling for repositories with GitHub Actions. In `/Users/kayaozkur/Documents/dev/dependencies/scripts/fork-management.py`, add:

```python
def check_github_actions(self, repo_path):
    """Check if repo has GitHub Actions that need consideration"""
    workflows_path = Path(repo_path) / ".github" / "workflows"
    if workflows_path.exists():
        workflows = list(workflows_path.glob("*.yml")) + list(workflows_path.glob("*.yaml"))
        if workflows:
            print(f"  📋 Found {len(workflows)} GitHub Actions workflows")
            print(f"  ⚠️  Note: This repo has automation that will create PRs")
            return True
    return False

def handle_special_repos(self, dep_name, config):
    """Special handling for repos with their own automation"""
    if dep_name == "ai-sdk-provider-claude-code":
        print(f"  🤖 This repo has integrated automation:")
        print(f"     - Dependabot for dependency updates")
        print(f"     - Upstream sync workflow")
        print(f"     - Claude Code specific monitoring")
        print(f"  ℹ️  Local sync will coordinate with GitHub Actions")
```

#### 4. Create Coordination Script

Create `/Users/kayaozkur/Documents/dev/dependencies/scripts/coordinate-updates.sh`:

```bash
#!/usr/bin/env bash

# Coordinates updates between local fork-first system and GitHub Actions

check_github_automation() {
    local repo_path=$1
    if [[ -d "$repo_path/.github/workflows" ]]; then
        echo "true"
    else
        echo "false"
    fi
}

sync_with_automation() {
    local dep_name=$1
    local repo_path=$2
    
    echo "🔄 Syncing $dep_name (has GitHub automation)"
    
    # First, check GitHub for any pending PRs
    cd "$repo_path"
    pending_prs=$(gh pr list --state open --label "automated" --json number,title)
    
    if [[ $(echo "$pending_prs" | jq length) -gt 0 ]]; then
        echo "  ⚠️  Found pending automated PRs:"
        echo "$pending_prs" | jq -r '.[] | "     PR #\(.number): \(.title)"'
        echo "  ℹ️  Review these PRs before running local sync"
        return 1
    fi
    
    # Run local sync
    if [[ -x "./scripts/local-sync.sh" ]]; then
        ./scripts/local-sync.sh
    fi
}
```

### Existing Dependencies Migration

#### What Happens to Existing Dependencies:

1. **No Breaking Changes**: All existing dependencies continue to work as before
2. **Enhanced Monitoring**: Dependencies can opt-in to GitHub Actions automation
3. **Gradual Migration**: Add GitHub workflows to other repos as needed

#### Migration Path for Existing Dependencies:

For each dependency that would benefit from automation, add:

1. **Dependabot config** (if it's an npm/pip/gem project)
2. **Upstream sync workflow** (if it's a fork)
3. **Keep fork-first protection** as the safety net

Example migration for `claude-squad`:
```yaml
# In claude-squad repo, add .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "npm"  # or pip, bundler, etc.
    directory: "/"
    schedule:
      interval: "weekly"
```

### Best Practices for Integration

1. **Fork-First Remains Primary**: GitHub Actions create PRs, but fork protection is the safety net
2. **Test-First Philosophy**: Both systems require tests to pass
3. **No Auto-Merge**: Human review required for all updates
4. **Backup Strategy**: Local backups + GitHub tags

### Coordination Commands

Add these to your shell profile:

```bash
# Check all dependencies with mixed management
alias dep-status='cd /Users/kayaozkur/Documents/dev/dependencies && ./scripts/sync.sh check && echo "Checking GitHub PRs..." && gh pr list --search "is:open label:automated"'

# Sync all with coordination
alias dep-sync-all='cd /Users/kayaozkur/Documents/dev/dependencies && ./scripts/coordinate-updates.sh'

# Quick check for ai-sdk-provider
alias check-ai-sdk='cd /Users/kayaozkur/Documents/ai-sdk-provider-claude-code && git status && gh pr list'
```

### Summary for the Agent

**Key Points:**
1. Read all reference files listed above
2. Add ai-sdk-provider-claude-code to sync-config.yml with special handling
3. Create the test script for integration
4. Enhance fork-management.py to recognize repos with GitHub automation
5. Create coordination script to handle mixed management
6. Existing dependencies remain unchanged unless explicitly migrated
7. Fork-first protection remains the primary safety mechanism

**Integration Philosophy:**
- Local fork-first system = Safety net and protection
- GitHub Actions = Automation and visibility
- Both systems work together, not in competition
- Human review required for all changes

**Testing the Integration:**
```bash
cd /Users/kayaozkur/Documents/dev/dependencies
./scripts/sync.sh sync ai-sdk-provider-claude-code
# Should recognize GitHub automation and coordinate appropriately
```

This creates a cohesive system where both approaches complement each other!