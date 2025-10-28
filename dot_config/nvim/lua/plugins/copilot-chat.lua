-- Minimal CopilotChat configuration with GPT-5 mini
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      model = "gpt-5-mini", -- Use GPT-5 mini as primary model
      auto_insert_mode = true, -- Enable edit mode
      window = {
        layout = "vertical",
        width = 0.4,
      },
    },
  },
}
