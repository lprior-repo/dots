# Sidekick.nvim Setup Guide

This guide explains how to set up and use sidekick.nvim with GitHub Copilot in your LazyVim configuration.

## What is Sidekick?

Sidekick.nvim is a Neovim plugin by Folke Lemaitre that integrates:
- **Copilot LSP's "Next Edit Suggestions" (NES)**: Get entire refactorings or multi-line changes anywhere in your file
- **AI CLI Terminal**: Built-in terminal for any AI CLI tool (GitHub Copilot CLI, Claude CLI, etc.)
- **Rich Diffs**: Visualize changes with inline and block-level diffs using Treesitter

## Prerequisites

1. **GitHub Copilot Subscription**: Active GitHub Copilot subscription
2. **GitHub Copilot CLI**: Install the Copilot CLI tool
   ```bash
   gh extension install github/gh-copilot
   ```
3. **Authenticate**: Make sure you're authenticated with GitHub
   ```bash
   gh auth login
   ```

## Configuration

The configuration has been added to your LazyVim setup:

### Files Modified
- `lua/config/lazy.lua`: Added `{ import = "lazyvim.plugins.extras.ai.sidekick" }`
- `lua/plugins/sidekick.lua`: Custom sidekick configuration with Copilot integration

### Key Features Configured

1. **Copilot LSP Integration**: Enabled for Next Edit Suggestions
2. **CLI Permissions**: Pre-configured with accept-all flags:
   - `--allow-tool 'shell'`: Auto-approve shell commands
   - `--allow-tool 'write'`: Auto-approve file writes
   - `--allow-all-paths`: Allow access to all paths

3. **Keybindings**:
   - `Alt+Enter` (`<M-CR>`): Jump to/apply next edit suggestion (won't conflict with Tab completion)
   - `Ctrl+.` (`<c-.>`): Toggle Sidekick CLI
   - `<leader>aa`: Alternative CLI toggle
   - `<leader>as`: Select AI tools

## Using Sidekick

### Next Edit Suggestions (NES)
1. Open a file in Neovim
2. Copilot will automatically suggest edits as you type
3. Press `Alt+Enter` to jump to the next suggestion or apply it
4. Review the diff and accept/reject changes

### AI CLI
1. Press `Ctrl+.` or `<leader>aa` to open the Sidekick CLI
2. The CLI will use GitHub Copilot by default with all permissions enabled
3. Type your prompt and let Copilot suggest commands or code
4. Commands will execute automatically without prompts (due to --allow-all flags)

## Security Note

⚠️ **IMPORTANT**: The configuration includes `--allow-all-paths` and auto-approval flags for convenience. This means:
- Copilot CLI can execute shell commands without asking
- Copilot CLI can write to files without confirmation
- Use this in trusted environments only

To use manual approval instead, edit `lua/plugins/sidekick.lua` and remove or modify the `args` in the `copilot` tool configuration.

## Troubleshooting

### Check Health
Run in Neovim:
```vim
:checkhealth sidekick
```

### Copilot Not Working
1. Verify Copilot LSP is running: `:LspInfo`
2. Check if copilot is authenticated: Run `gh copilot` in terminal
3. Restart Neovim after installing plugins: `:Lazy sync`

### NES Not Showing Suggestions
1. Make sure Neovim is 0.10.1 or later
2. Verify Copilot LSP is enabled: `:lua =vim.lsp.get_clients()`
3. Check that you're using the latest version of sidekick.nvim

## Additional Resources

- [Sidekick.nvim GitHub](https://github.com/folke/sidekick.nvim)
- [LazyVim Sidekick Extra](https://www.lazyvim.org/extras/ai/sidekick)
- [GitHub Copilot CLI Docs](https://docs.github.com/en/copilot/concepts/agents/about-copilot-cli)

## Available Copilot Models

When using the CLI, you can specify different models:
- Claude 3.5 Sonnet
- GPT-4 variants
- Gemini models
- And more (check with `:lua require('sidekick.cli').select_tool()`)

The models are fetched dynamically from GitHub Copilot's API based on your subscription.
