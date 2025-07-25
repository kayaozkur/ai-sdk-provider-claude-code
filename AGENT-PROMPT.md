# Prompt for Dependencies Repository Agent

## Task Overview
Integrate the ai-sdk-provider-claude-code repository's dependency management approach with the existing fork-first system in `/Users/kayaozkur/Documents/dev/dependencies`.

## Context
- The ai-sdk-provider-claude-code repo now has GitHub Actions automation for dependency updates
- The existing dependencies system uses fork-first protection with the `proj_dep_` prefix
- Both systems should work together cohesively

## Your Tasks

### 1. Read These Files First (In Order)
```bash
# Understand the new automation approach
cat /Users/kayaozkur/Documents/ai-sdk-provider-claude-code/INTEGRATION-INSTRUCTIONS.md
cat /Users/kayaozkur/Documents/ai-sdk-provider-claude-code/docs/SYNC-AND-UPDATE.md
cat /Users/kayaozkur/Documents/ai-sdk-provider-claude-code/.github/workflows/integrated-dependency-sync.yml

# Review existing system
cat /Users/kayaozkur/Documents/dev/dependencies/README.md
cat /Users/kayaozkur/Documents/dev/dependencies/config/sync-config.yml
```

### 2. Primary Actions Required

1. **Add ai-sdk-provider-claude-code to sync-config.yml** with the configuration provided in INTEGRATION-INSTRUCTIONS.md

2. **Create test script**: `/Users/kayaozkur/Documents/dev/dependencies/tests/dependency-tests/test-ai-sdk-provider-claude-code.sh`

3. **Enhance fork-management.py** to recognize repositories with GitHub Actions

4. **Create coordinate-updates.sh** to handle mixed management scenarios

### 3. Key Principles to Maintain

- **DO NOT** remove or modify existing dependencies
- **DO NOT** change the fork-first protection system
- **ADD** integration points for repos with GitHub automation
- **ENSURE** test-first philosophy is maintained
- **PRESERVE** the `proj_dep_` naming convention

### 4. Expected Outcome

After your changes:
- Running `./scripts/sync.sh sync ai-sdk-provider-claude-code` should recognize it has GitHub automation
- The system should check for pending GitHub PRs before local sync
- All existing dependencies continue to work unchanged
- The integration is seamless and non-breaking

### 5. Verification Steps

```bash
# Test the integration
cd /Users/kayaozkur/Documents/dev/dependencies
./scripts/sync.sh check
./scripts/sync.sh sync ai-sdk-provider-claude-code

# Verify test script works
./tests/dependency-tests/test-ai-sdk-provider-claude-code.sh

# Check coordination
./scripts/coordinate-updates.sh ai-sdk-provider-claude-code /Users/kayaozkur/Documents/ai-sdk-provider-claude-code
```

## Important Notes

1. **Existing Dependencies**: Leave them exactly as they are. Only ai-sdk-provider-claude-code gets special handling.

2. **Fork Protection**: The `proj_dep_` prefix system remains unchanged and primary.

3. **No Breaking Changes**: Everything that works now should continue working.

4. **Questions**: If anything is unclear, refer to INTEGRATION-INSTRUCTIONS.md which has comprehensive details.

## Summary
You're adding integration points for repositories that have their own GitHub automation while preserving the existing fork-first protection system. Think of it as adding a coordination layer, not replacing anything.