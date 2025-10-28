-- Minimal Avante configuration with GPT-5 mini via Copilot
return {
  {
    "yetone/avante.nvim",
    opts = {
      provider = "copilot", -- Use GitHub Copilot as provider
      copilot = {
        model = "gpt-5-mini", -- Use GPT-5 mini as primary model
      },
      behaviour = {
        auto_set_keymaps = false, -- Let LazyVim handle keymaps
      },
    },
  },
}
