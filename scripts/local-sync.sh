#!/usr/bin/env bash

# Local sync script that integrates with your fork-first system
# Can be run manually or integrated with your existing tools

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
FORK_PREFIX="proj_dep_"
UPSTREAM_REPO="ben-vargas/ai-sdk-provider-claude-code"
FORK_NAME="${FORK_PREFIX}ai-sdk-provider-claude-code"

print_status() {
    local status=$1
    local message=$2
    case $status in
        "success") echo -e "${GREEN}✓${NC} ${message}" ;;
        "error") echo -e "${RED}✗${NC} ${message}" ;;
        "warning") echo -e "${YELLOW}⚠${NC} ${message}" ;;
        "info") echo -e "${BLUE}ℹ${NC} ${message}" ;;
    esac
}

# Check if we're in the right directory
check_environment() {
    if [[ ! -f "$PROJECT_ROOT/package.json" ]]; then
        print_status "error" "Not in ai-sdk-provider-claude-code directory"
        exit 1
    fi
    
    # Check for your dependency management system
    if [[ -d "/Users/kayaozkur/Documents/dev/dependencies" ]]; then
        print_status "info" "Found dependency management system"
        export DEP_MGMT_DIR="/Users/kayaozkur/Documents/dev/dependencies"
    fi
}

# Verify fork protection
verify_fork() {
    print_status "info" "Verifying fork protection..."
    
    # Check if fork exists
    if gh repo view "kayaozkur/$FORK_NAME" >/dev/null 2>&1; then
        print_status "success" "Fork exists: kayaozkur/$FORK_NAME"
        return 0
    else
        print_status "warning" "Fork not found. Creating with protection prefix..."
        
        # Use your fork management system if available
        if [[ -n "${DEP_MGMT_DIR:-}" ]] && [[ -f "$DEP_MGMT_DIR/scripts/fork-management.py" ]]; then
            cd "$DEP_MGMT_DIR"
            python scripts/fork-management.py create "$UPSTREAM_REPO" "ai-sdk-provider-claude-code"
            cd "$PROJECT_ROOT"
        else
            # Fallback to manual fork
            gh repo fork "$UPSTREAM_REPO" --clone=false --fork-name="$FORK_NAME"
        fi
    fi
}

# Test before update
run_tests() {
    print_status "info" "Running tests before update..."
    
    local test_passed=true
    
    # Build
    if ! npm run build >/dev/null 2>&1; then
        print_status "error" "Build failed"
        test_passed=false
    else
        print_status "success" "Build passed"
    fi
    
    # Type check
    if ! npm run typecheck >/dev/null 2>&1; then
        print_status "error" "Type check failed"
        test_passed=false
    else
        print_status "success" "Type check passed"
    fi
    
    # Tests
    if ! npm test >/dev/null 2>&1; then
        print_status "error" "Tests failed"
        test_passed=false
    else
        print_status "success" "Tests passed"
    fi
    
    if [[ "$test_passed" == "false" ]]; then
        return 1
    fi
    return 0
}

# Check for Claude Code updates
check_claude_code_updates() {
    print_status "info" "Checking @anthropic-ai/claude-code updates..."
    
    local current_version=$(node -p "require('./package.json').dependencies['@anthropic-ai/claude-code']")
    local latest_version=$(npm view @anthropic-ai/claude-code version)
    
    if [[ "$current_version" != "^$latest_version" ]]; then
        print_status "warning" "Update available: $current_version → ^$latest_version"
        
        # Create backup
        local backup_tag="backup-claude-$(date +%Y%m%d-%H%M%S)"
        git tag -a "$backup_tag" -m "Backup before claude-code update"
        print_status "info" "Created backup tag: $backup_tag"
        
        # Update with exact version
        npm install @anthropic-ai/claude-code@latest --save-exact
        
        # Test update
        if run_tests; then
            print_status "success" "Claude Code updated successfully"
            return 0
        else
            print_status "error" "Update failed tests, rolling back..."
            git checkout -- package.json package-lock.json
            npm install
            return 1
        fi
    else
        print_status "success" "Claude Code is up to date"
    fi
}

# Sync with upstream
sync_upstream() {
    print_status "info" "Syncing with upstream repository..."
    
    # Add upstream if not exists
    if ! git remote get-url upstream >/dev/null 2>&1; then
        git remote add upstream "https://github.com/$UPSTREAM_REPO.git"
    fi
    
    # Fetch upstream
    git fetch upstream
    
    # Check for updates
    local behind=$(git rev-list HEAD..upstream/main --count)
    
    if [[ "$behind" -gt 0 ]]; then
        print_status "warning" "Repository is $behind commits behind upstream"
        print_status "info" "Create a sync branch to merge changes:"
        echo "  git checkout -b sync-upstream-$(date +%Y%m%d)"
        echo "  git merge upstream/main"
        echo "  # Resolve conflicts if any"
        echo "  git push origin sync-upstream-$(date +%Y%m%d)"
    else
        print_status "success" "Repository is up to date with upstream"
    fi
}

# Main execution
main() {
    echo -e "${BLUE}=== AI SDK Provider Claude Code - Local Sync ===${NC}\n"
    
    check_environment
    verify_fork
    
    # Menu
    echo "What would you like to do?"
    echo "1) Check Claude Code updates"
    echo "2) Sync with upstream"
    echo "3) Run full sync (both)"
    echo "4) Run tests only"
    echo "5) Exit"
    
    read -p "Select option (1-5): " choice
    
    case $choice in
        1)
            check_claude_code_updates
            ;;
        2)
            sync_upstream
            ;;
        3)
            check_claude_code_updates
            sync_upstream
            ;;
        4)
            run_tests
            ;;
        5)
            exit 0
            ;;
        *)
            print_status "error" "Invalid option"
            exit 1
            ;;
    esac
}

# Run main
main "$@"