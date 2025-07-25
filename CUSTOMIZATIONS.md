# Customizations in This Fork

This file documents all customizations made to this fork that differ from the upstream repository.

## GitHub Workflows (Added)

### 1. Dependabot Configuration (`.github/dependabot.yml`)
- Automated dependency updates
- Special priority for @anthropic-ai/claude-code
- Grouped updates to reduce noise

### 2. Sync Upstream Workflow (`.github/workflows/sync-upstream.yml`)
- Daily sync with ben-vargas/ai-sdk-provider-claude-code
- Automated PR creation for upstream changes
- Conflict detection and reporting

### 3. Claude Code Update Monitor (`.github/workflows/claude-code-update.yml`)
- Twice-daily checks for @anthropic-ai/claude-code updates
- Automated PR creation with exact version pinning
- Test execution before PR creation

### 4. Protect Custom Changes (`.github/workflows/protect-custom-changes.yml`)
- Analyzes PRs to identify custom changes
- Creates backup tags before merges
- Comments on PRs with customization report

### 5. Claude Code Review (`.github/workflows/claude-code-review.yml`)
- From original repo - reviews PRs automatically

### 6. Claude PR Assistant (`.github/workflows/claude-pr-assistant.yml`)
- From original repo - assists with PR creation

## Documentation (Added)

### 1. `docs/SYNC-AND-UPDATE.md`
- Comprehensive guide for the sync and update strategy
- Instructions for handling conflicts
- Best practices for maintaining the fork

### 2. `CUSTOMIZATIONS.md` (This file)
- Living document of all customizations
- Must be updated when adding new custom features

## Configuration Changes

### 1. Repository Settings (Recommended)
- Branch protection rules should allow bot commits
- Dependabot should be enabled in repository settings
- GitHub Actions should have write permissions

## How to Preserve These Customizations

1. **Never force push** to main branch
2. **Always review** automated PRs before merging
3. **Document new customizations** in this file
4. **Use meaningful commit messages** for custom changes
5. **Tag important versions** before major updates

## Upstream Compatibility

These customizations are designed to:
- Not interfere with upstream functionality
- Be easily identifiable and separable
- Enhance rather than modify core behavior
- Be documented and maintainable

## Regular Maintenance

1. Review this file monthly
2. Update when adding new customizations
3. Remove entries for customizations that get upstreamed
4. Keep GitHub workflows up to date with latest actions

---

Last updated: {{ current_date }}
Maintained by: @kayaozkur