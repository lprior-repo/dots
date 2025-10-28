return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    opts = {
      -- Enable auto insert mode (edit mode)
      auto_insert_mode = true,

      -- Generic window configuration
      window = {
        layout = "vertical", -- vertical split for better editing workflow
        width = 0.4, -- 40% of screen width
      },

      -- Generic selection behavior
      selection = function(source)
        local select = require("CopilotChat.select")
        return select.unnamed(source) -- Use unnamed register for selections
      end,

      -- Standard prompts (kept generic)
      prompts = {
        Explain = {
          prompt = "/COPILOT_EXPLAIN Write an explanation for the selected code as paragraphs of text.",
        },
        Review = {
          prompt = "/COPILOT_REVIEW Review the selected code.",
        },
        Fix = {
          prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.",
        },
        Optimize = {
          prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readability.",
        },
        Docs = {
          prompt = "/COPILOT_GENERATE Please add documentation comments to the selected code.",
        },
        Tests = {
          prompt = "/COPILOT_GENERATE Please generate tests for the selected code.",
        },
        Commit = {
          prompt = "/COPILOT_GENERATE Write a commit message for the change with commitizen convention.",
        },
      },

      -- Generic mappings (LazyVim defaults)
      mappings = {
        complete = {
          insert = "<C-Space>", -- Complete in insert mode
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-l>",
          insert = "<C-l>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        toggle_sticky = {
          detail = "Toggle sticky mode (makes chat stick to current file)",
          normal = "<leader>cs",
        },
      },
    },
    keys = {
      -- Generic keybindings aligned with LazyVim conventions
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
    },
  },
}
