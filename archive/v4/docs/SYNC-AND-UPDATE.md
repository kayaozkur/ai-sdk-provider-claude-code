# Sync and Update Strategy

This document explains how this fork stays synchronized with the upstream repository while maintaining custom changes.

## Overview

This repository implements a three-pronged approach to stay current:

1. **Dependabot** - Automated dependency updates
2. **Upstream Sync** - Syncing with the original repository
3. **Claude Code Monitor** - Specific monitoring for @anthropic-ai/claude-code updates

## 1. Dependabot Configuration

Located at `.github/dependabot.yml`, this handles:

- **Daily checks** for all npm dependencies
- **Grouped updates** to reduce PR noise
- **Priority handling** for @anthropic-ai/claude-code
- **Automated PR creation** with proper labels and assignees

### Key Features:
- Development dependencies are grouped together
- AI SDK dependencies are grouped together
- Claude Code updates get priority treatment

## 2. Upstream Sync Workflow

Located at `.github/workflows/sync-upstream.yml`, this:

- **Runs daily** (or on manual trigger)
- **Creates PRs** with upstream changes
- **Preserves your customizations**
- **Handles merge conflicts** gracefully

### How it works:
1. Fetches latest changes from `ben-vargas/ai-sdk-provider-claude-code`
2. Creates a new branch with timestamp
3. Attempts to merge upstream changes
4. Creates a PR for review (with conflict warnings if applicable)

### Manual Trigger:
```bash
# Via GitHub UI: Actions > Sync with Upstream > Run workflow
# Can specify different branch to sync from
```

## 3. Claude Code Update Monitor

Located at `.github/workflows/claude-code-update.yml`, this:

- **Checks twice daily** for new Claude Code SDK versions
- **Updates to exact latest version** when available
- **Runs tests** before creating PR
- **Provides detailed PR description** with version changes

### Features:
- Uses exact versioning for claude-code dependency
- Automatically updates both package.json and package-lock.json
- Includes test results in PR
- High-priority labeling for quick attention

## Handling Updates

### When Dependabot Creates a PR:
1. Review the changes in the PR
2. Check the CI/test results
3. Test locally if needed: `npm install && npm test`
4. Merge when satisfied

### When Upstream Sync Creates a PR:
1. **No conflicts**: Review changes, test, and merge
2. **With conflicts**: 
   ```bash
   git checkout sync-upstream-branch
   git pull origin sync-upstream-branch
   # Resolve conflicts manually
   git add .
   git commit -m "Resolve merge conflicts"
   git push
   ```

### When Claude Code Update Creates a PR:
1. This is high priority - review promptly
2. Check the linked release notes
3. Test with your specific use cases
4. Merge to get latest SDK features

## Best Practices

### Preserving Your Changes:
1. **Document customizations** in comments
2. **Use meaningful commit messages** for your changes
3. **Keep customizations minimal** and well-organized
4. **Add tests** for your custom features

### Conflict Resolution:
- Your changes are preserved in Git history
- Conflicts usually occur in:
  - package.json (version numbers)
  - README.md (documentation)
  - Source files with customizations

### Testing After Updates:
```bash
# Always run after updates
npm install
npm run build
npm test
npm run example:all  # Test all examples
```

## Customization

### Modify Update Frequency:
Edit the cron schedules in workflow files:
```yaml
schedule:
  - cron: '0 2 * * *'  # Daily at 2 AM UTC
```

### Change Assignees/Reviewers:
Update in workflow files:
```yaml
assignees: kayaozkur
reviewers: kayaozkur
```

### Disable Specific Automation:
Simply delete or rename the workflow file you don't want.

## Troubleshooting

### If updates fail:
1. Check GitHub Actions logs
2. Ensure branch protections allow bot commits
3. Verify npm registry is accessible
4. Check for breaking changes in dependencies

### If merge conflicts persist:
1. Consider rebasing your changes
2. Split large customizations into separate files
3. Use patch files for upstream modifications

## Summary

This setup ensures:
- ✅ You always have the latest @anthropic-ai/claude-code SDK
- ✅ You stay in sync with upstream improvements
- ✅ Your customizations are preserved
- ✅ Updates are automated but reviewed
- ✅ Conflicts are handled gracefully

The automation runs in the background, creating PRs for your review. You maintain full control over what gets merged and when.