# Community Provider Status Analysis (v5-beta)

## Overview
This document analyzes the requirements for ai-sdk-provider-claude-code to achieve community provider status in the Vercel AI SDK v5-beta ecosystem.

## Current Implementation Status

### ✅ What We Have

#### Core Functionality
- **SDK Integration**: Uses official `@anthropic-ai/claude-code` SDK for all Claude interactions
- **Text Generation**: Full support for both streaming and non-streaming text generation with v5 patterns
- **Object Generation**: Reliable JSON generation through prompt engineering and extraction
- **Multi-turn Conversations**: Proper message history support with v5 message format
- **Provider Metadata**: Rich metadata including sessionId, costUsd, durationMs, and rawUsage
- **Error Handling**: Comprehensive error handling with authentication detection
- **AbortSignal Support**: Standard AI SDK pattern for timeouts and cancellation

#### v5-Beta Specific Features
- **LanguageModelV2 Implementation**: Fully compliant with `specificationVersion: 'v2'`
- **Stream-Start Event**: Properly emits initial stream event with warnings
- **Token Usage Naming**: Uses v5 convention (inputTokens, outputTokens, totalTokens)
- **Message Format**: Supports v5's array-based content structure
- **Promise-based Streaming**: Implements v5's new streaming API pattern

#### Build & Distribution
- **TypeScript**: Full TypeScript support with proper type definitions
- **Dual Formats**: Both CommonJS and ES Module builds via tsup
- **Source Maps**: Generated for debugging support
- **Package Structure**: Proper exports configuration for modern Node.js
- **Beta Tag**: Published with `beta` tag on npm

#### Testing
- **Unit Tests**: Comprehensive test coverage with Vitest
- **Integration Tests**: Full integration test suite
- **Edge/Node Tests**: Separate configurations for different environments
- **Examples**: Extensive example collection demonstrating all v5 features

#### Documentation
- **README**: Comprehensive documentation with version compatibility matrix
- **CHANGELOG**: Proper version history following Keep a Changelog format
- **Examples README**: Detailed guide for all example files
- **API Documentation**: Clear documentation of all configuration options
- **Migration Guide**: Comprehensive v4 to v5 migration documentation

### 🚀 Meeting AI SDK v5-Beta Standards

Based on analysis of official v5-beta providers, we now meet all requirements:

1. **Provider Pattern** ✅
   - Factory function with provider instance
   - Default export
   - Proper settings interface
   - Protection against `new` keyword misuse

2. **Language Model Implementation** ✅
   - `specificationVersion: 'v2'`
   - Correct `doGenerate` and `doStream` methods for v5
   - Proper provider metadata
   - Object generation support
   - Stream-start event emission

3. **Build System** ✅
   - tsup for dual format builds
   - Source maps
   - Proper package.json configuration
   - Beta tag in publishConfig

4. **Testing** ✅
   - Separate edge/node configurations
   - Unit and integration tests
   - Example test coverage
   - All tests passing with v5 patterns

5. **Error Handling** ✅
   - Standard AI SDK error classes
   - Proper `isRetryable` flags
   - AbortSignal support

## 📁 Current Project Structure

```
ai-sdk-provider-claude-code/
├── src/
│   ├── index.ts                          # Main exports
│   ├── claude-code-provider.ts           # Provider factory
│   ├── claude-code-language-model.ts     # Language model implementation (v2)
│   ├── convert-to-claude-code-messages.ts # Message formatting (v5 format)
│   ├── extract-json.ts                   # JSON extraction (using jsonc-parser)
│   ├── errors.ts                         # Error utilities
│   └── types.ts                          # TypeScript definitions
├── docs/
│   ├── ai-sdk-v4/                        # v4-specific documentation (archived)
│   │   ├── GUIDE.md
│   │   ├── TROUBLESHOOTING.md
│   │   └── DEVELOPMENT-STATUS.md
│   └── ai-sdk-v5/                        # v5-beta documentation
│       ├── GUIDE.md                      # v5-specific usage guide
│       ├── TROUBLESHOOTING.md            # v5-specific troubleshooting
│       ├── DEVELOPMENT-STATUS.md         # This document
│       ├── V5_BREAKING_CHANGES.md        # User migration guide
│       ├── V5_MIGRATION_PLAN.md          # Technical migration plan
│       ├── V5_MIGRATION_SUMMARY.md       # Migration implementation summary
│       └── V5_MIGRATION_TASKS.md         # Migration task tracking
├── examples/
│   ├── README.md                         # Examples guide
│   ├── basic-usage.ts                    # Simple generation (v5 pattern)
│   ├── streaming.ts                      # Streaming demo (v5 pattern)
│   ├── conversation-history.ts           # Multi-turn conversations (v5 format)
│   ├── custom-config.ts                  # Configuration options
│   ├── generate-object-*.ts              # Object generation examples
│   ├── tool-management.ts                # Tool access control
│   ├── long-running-tasks.ts             # Timeout handling
│   ├── abort-signal.ts                   # Cancellation
│   ├── integration-test.ts               # Test suite
│   └── check-cli.ts                      # Setup verification
├── vitest.config.js                      # Test configuration
├── vitest.edge.config.js                 # Edge runtime tests
├── vitest.node.config.js                 # Node runtime tests
├── tsup.config.ts                        # Build configuration
├── package.json                          # Package metadata (v1.0.0-beta.1)
├── CHANGELOG.md                          # Version history
├── README.md                             # Main documentation with version matrix
└── LICENSE                               # MIT license
```

## 🎯 Ready for Community Status

The provider now meets all requirements for v5-beta community provider status:

### Technical Requirements ✅
- Implements LanguageModelV2 specification
- Follows provider factory pattern
- Uses standard error handling
- Supports AbortSignal
- Has proper TypeScript types
- Includes comprehensive tests
- Emits stream-start event
- Uses v5 token naming convention

### Build Requirements ✅
- Uses tsup for builds
- Generates both CJS and ESM
- Includes source maps
- Has proper package.json configuration
- Published with beta tag

### Documentation Requirements ✅
- Comprehensive README with version compatibility
- CHANGELOG with version history
- Extensive examples using v5 patterns
- Clear setup instructions
- Migration guide from v4

## Version Strategy

- **0.x versions**: AI SDK v4 compatibility (maintained on `ai-sdk-v4` branch)
- **1.x-beta versions**: AI SDK v5-beta compatibility (maintained on `main` branch)

## Next Steps for Community Submission

1. **Publish to npm with beta tag**
   ```bash
   npm publish --tag beta
   ```

2. **Prepare MDX Documentation**
   Create a documentation file following the v5-beta community provider format (see example below)

3. **Submit PR to AI SDK Repository**
   - Add provider to v5-beta community providers list
   - Include MDX documentation
   - Reference npm package with beta tag

## Example Community Provider MDX (v5-beta)

```mdx
---
title: Claude Code (v5-beta)
description: Use Claude via the official Claude Code SDK with your Pro/Max subscription
---

# Claude Code Provider (v5-beta)

[ben-vargas/ai-sdk-provider-claude-code](https://github.com/ben-vargas/ai-sdk-provider-claude-code) 
is a community provider that uses the official [Claude Code SDK](https://www.npmjs.com/package/@anthropic-ai/claude-code) 
to provide language model support for the AI SDK v5-beta.

<Note type="warning">
  This is the v5-beta compatible version. For AI SDK v4 support, use version 0.2.x.
</Note>

## Setup

The Claude Code provider is available in the `ai-sdk-provider-claude-code` module. You can install it with:

<Tabs items={['pnpm', 'npm', 'yarn']}>
  <Tab>
    <Snippet text="pnpm add ai-sdk-provider-claude-code@beta ai@beta" dark />
  </Tab>
  <Tab>
    <Snippet text="npm install ai-sdk-provider-claude-code@beta ai@beta" dark />
  </Tab>
  <Tab>
    <Snippet text="yarn add ai-sdk-provider-claude-code@beta ai@beta" dark />
  </Tab>
</Tabs>

### Prerequisites

Install and authenticate the Claude Code SDK:

```bash
npm install -g @anthropic-ai/claude-code
claude login
```

## Provider Instance

You can import the default provider instance `claudeCode` from `ai-sdk-provider-claude-code`:

```ts
import { claudeCode } from 'ai-sdk-provider-claude-code';
```

## Language Models

The Claude Code provider supports the following models:

- `sonnet` - Claude 4 Sonnet (balanced speed and capability)
- `opus` - Claude 4 Opus (most capable)

```ts
import { generateText } from 'ai';
import { claudeCode } from 'ai-sdk-provider-claude-code';

const result = await generateText({
  model: claudeCode('sonnet'),
  prompt: 'Explain recursion in one sentence',
});

console.log(result.text);
```

### Model Capabilities

| Model | Text Generation | Object Generation | Image Input | AI SDK Tool Calling | MCP Tools |
|-------|----------------|-------------------|-------------|---------------------|-----------|
| opus  | ✅ | ✅ | ❌ | ❌ | ✅ |
| sonnet | ✅ | ✅ | ❌ | ❌ | ✅ |

<Note>
  The provider uses the official Claude Code SDK. While the models support tool use, this provider 
  doesn't implement the AI SDK's tool calling interface. However, you can configure MCP servers 
  for tool functionality, and Claude can use built-in tools (Bash, Read, Write, etc.) through 
  the Claude Code SDK.
</Note>

## v5-Beta Specific Features

This version includes full support for AI SDK v5-beta features:

- **New streaming API** with promise-based result objects
- **Updated token usage** properties (inputTokens, outputTokens, totalTokens)
- **Stream-start events** for better stream initialization
- **Array-based message content** format

```ts
// v5 streaming pattern
const result = streamText({
  model: claudeCode('sonnet'),
  prompt: 'Write a haiku',
});

const text = await result.text;
const usage = await result.usage;
```

See the [migration guide](https://github.com/ben-vargas/ai-sdk-provider-claude-code/blob/main/docs/ai-sdk-v5/V5_BREAKING_CHANGES.md) for details on upgrading from v0.x to v1.x-beta.
```