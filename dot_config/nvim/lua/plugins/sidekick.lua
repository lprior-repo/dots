return {
  {
    "folke/sidekick.nvim",
    opts = {
      -- Enable Next Edit Suggestions from Copilot LSP
      nes = {
        enabled = true,
      },
      -- Configure CLI settings
      cli = {
        -- Enable terminal multiplexer integration
        mux = {
          enabled = true,
        },
        -- Default CLI tool configuration
        tools = {
          -- Configure GitHub Copilot CLI with accept-all permissions
          copilot = {
            -- Available flags:
            -- --allow-all-tools: Allow all tools without prompts (use with caution)
            -- --allow-tool 'shell': Allow shell commands
            -- --allow-tool 'write': Allow file writes
            -- --allow-all-paths: Allow access to all paths
            args = { "--allow-tool", "shell", "--allow-tool", "write", "--allow-all-paths" },
          },
        },
      },
    },
    keys = {
      -- Use Alt+Enter for sidekick NES to avoid conflicts with Tab completion
      {
        "<M-CR>",
        function()
          -- Jump to or apply next edit suggestion
          if not require("sidekick").nes_jump_or_apply() then
            return "<M-CR>"
          end
        end,
        expr = true,
        desc = "Sidekick: Goto/Apply Next Edit Suggestion",
        mode = { "n", "i" },
      },
      -- Toggle Sidekick CLI
      {
        "<c-.>",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick: Toggle CLI",
        mode = { "n", "t", "i", "x" },
      },
      -- Alternative toggle with leader key
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick: Toggle CLI",
        mode = { "n", "i", "x" },
      },
      -- Select tools
      {
        "<leader>as",
        function()
          require("sidekick.cli").select_tool()
        end,
        desc = "Sidekick: Select Tools",
        mode = "n",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Configure Copilot LSP server
        copilot = {
          -- Enable for sidekick NES integration
          enabled = true,
        },
      },
    },
  },
}
