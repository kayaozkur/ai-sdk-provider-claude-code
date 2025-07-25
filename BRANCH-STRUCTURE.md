# Branch Structure Explanation for ai-sdk-provider-claude-code

## Overview

This repository maintains compatibility with two major versions of the Vercel AI SDK through separate branches.

## Current Branch Structure

### 1. **main** (Default Branch)

- **AI SDK Version**: v4 (stable)
- **Status**: Production-ready
- **Package Version**: 0.2.2
- **Claude Code SDK**: ^1.0.60 (latest)
- **Features**:
  - Full AI SDK v4 compatibility
  - All automation workflows (Dependabot, Claude Code monitor, upstream sync)
  - Fork protection integration
  - Stable and tested

**Use this branch if**: You're using AI SDK v4 in your projects

### 2. **v5-with-automation**

- **AI SDK Version**: v5-beta
- **Status**: Beta
- **Package Version**: 1.0.0-beta.1
- **Claude Code SDK**: 1.0.60 (exact version)
- **Features**:
  - Full AI SDK v5-beta compatibility
  - All automation workflows
  - Updated streaming APIs
  - New token usage properties
  - Breaking changes from v4

**Use this branch if**: You're using AI SDK v5-beta in your projects

### 3. **v5-beta-upstream** (Reference Only)

- **Purpose**: Clean copy of Ben Vargas' v5 implementation
- **Status**: Reference branch - DO NOT modify
- **Use**: For comparing changes and pulling updates from upstream

### 4. **add-dependency-automation** (PR Branch)

- **Purpose**: Pull Request #28 to Ben Vargas
- **Contains**: Only universal automation features (Dependabot + Claude Code monitor)
- **Status**: Pending review

## Key Differences Between v4 and v5

### Breaking Changes:

1. **Token Usage Properties**:
   - v4: `promptTokens`, `completionTokens`
   - v5: `inputTokens`, `outputTokens`, `totalTokens`

2. **Streaming Response**:
   - v4: Direct destructuring
   - v5: Returns promises that need to be awaited

3. **Message Format**:
   - v4: `content` can be string
   - v5: `content` must be array of parts

4. **Import Changes**:
   - v4: Uses AI SDK v4 imports
   - v5: Uses AI SDK v5-beta imports

## Installation Instructions

### For AI SDK v4 (Stable):
```bash
git clone https://github.com/kayaozkur/ai-sdk-provider-claude-code.git
cd ai-sdk-provider-claude-code
git checkout main
npm install
```

### For AI SDK v5-beta:
```bash
git clone https://github.com/kayaozkur/ai-sdk-provider-claude-code.git
cd ai-sdk-provider-claude-code
git checkout v5-with-automation
npm install
```

## Automation Features (Present in Both v4 and v5)

1. **Dependabot**: Daily dependency updates
2. **Claude Code Monitor**: Twice-daily checks for @anthropic-ai/claude-code updates
3. **Upstream Sync**: Daily sync with ben-vargas/ai-sdk-provider-claude-code
4. **Fork Protection**: Integration with existing dependency management system
5. **Local Sync Script**: Manual coordination tool

## For Agents Working with This Repository

### To Work on v4 Features:
```bash
git checkout main
# Make changes
# Test with: npm test
# All automation is already configured
```

### To Work on v5 Features:
```bash
git checkout v5-with-automation
# Make changes
# Test with: npm test
# Note: Some tests fail due to Claude Code SDK v1.0.60 changes
```

### Important Notes:
- Both branches have identical automation workflows
- Both branches have the latest Claude Code SDK
- The main difference is AI SDK compatibility (v4 vs v5-beta)
- Never merge between v4 and v5 branches (breaking changes)
- Fork protection (proj_dep_ prefix) works with both versions

## Repository Remotes

- **origin**: kayaozkur/ai-sdk-provider-claude-code (your fork)
- **upstream**: ben-vargas/ai-sdk-provider-claude-code (original)
- **nicolas**: nicolascoutureau/ai-sdk-provider-claude-code (intermediate fork)

This dual-branch strategy allows users to choose the appropriate version based on their AI SDK version while maintaining all automation and integration features in both versions.