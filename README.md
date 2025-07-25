<p align="center">
  <img src="https://img.shields.io/badge/warning-alpha-FF6700" alt="alpha warning">
  <a href="https://www.npmjs.com/package/ai-sdk-provider-claude-code"><img src="https://img.shields.io/npm/v/ai-sdk-provider-claude-code?color=00A79E" alt="npm version" /></a>
  <a href="https://www.npmjs.com/package/ai-sdk-provider-claude-code"><img src="https://img.shields.io/npm/unpacked-size/ai-sdk-provider-claude-code?color=00A79E" alt="install size" /></a>
  <a href="https://www.npmjs.com/package/ai-sdk-provider-claude-code"><img src="https://img.shields.io/npm/dy/ai-sdk-provider-claude-code.svg?color=00A79E" alt="npm downloads" /></a>
  <a href="https://nodejs.org/en/about/releases/"><img src="https://img.shields.io/badge/node-%3E%3D18-00A79E" alt="Node.js ≥ 18" /></a>
  <a href="https://www.npmjs.com/package/ai-sdk-provider-claude-code"><img src="https://img.shields.io/npm/l/ai-sdk-provider-claude-code?color=00A79E" alt="License: MIT" /></a>
</p>

# AI SDK Provider for Claude Code SDK

> **Warning**: This package is experimental and subject to change.

**ai-sdk-provider-claude-code** lets you use Claude via the [Vercel AI SDK](https://sdk.vercel.ai/docs) through the official `@anthropic-ai/claude-code` SDK/CLI.

## Installation

### 1. Install and authenticate the CLI

#### Windows
```bash
# Install Claude Code CLI (now with native Windows support!)
npm install -g @anthropic-ai/claude-code
claude login
```

#### macOS/Linux
```bash
npm install -g @anthropic-ai/claude-code
claude login
```

### 2. Add the provider
```bash
npm install ai-sdk-provider-claude-code ai
```

## Disclaimer

**This is an unofficial community provider** and is not affiliated with or endorsed by Anthropic or Vercel. By using this provider:

- You understand that your data will be sent to Anthropic's servers through the Claude Code SDK
- You agree to comply with [Anthropic's Terms of Service](https://www.anthropic.com/legal/consumer-terms)
- You acknowledge this software is provided "as is" without warranties of any kind

Please ensure you have appropriate permissions and comply with all applicable terms when using this provider.

## Quick Start

```typescript
import { generateText } from 'ai';
import { claudeCode } from 'ai-sdk-provider-claude-code';

const { text } = await generateText({
  model: claudeCode('sonnet'),
  prompt: 'Hello, Claude!'
});

console.log(text);
```

## Models

- **`opus`** - Claude 4 Opus (most capable)
- **`sonnet`** - Claude 4 Sonnet (balanced performance)

## Documentation

- **[Usage Guide](docs/GUIDE.md)** - Comprehensive examples and configuration
- **[Troubleshooting](docs/TROUBLESHOOTING.md)** - Common issues and solutions
- **[Examples](examples/)** - Sample scripts and patterns

## Core Features

- Vercel AI SDK compatibility
- Streaming support
- Multi-turn conversations
- Object generation with JSON schemas
- AbortSignal support
- Tool management (MCP servers, permissions)

## Limitations

- Requires Node.js ≥ 18
- Works on Windows, macOS, and Linux (native Windows support as of Claude Code v1.0.60+)
- No image support
- Some AI SDK parameters unsupported (temperature, maxTokens, etc.)

## Contributing

We welcome contributions, especially:
- Code structure improvements
- Performance optimizations
- Better error handling
- Additional examples

See [Contributing Guidelines](docs/GUIDE.md#contributing) for details.

For development status and technical details, see [Development Status](docs/DEVELOPMENT-STATUS.md).

## License

MIT
