return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "folke/snacks.nvim",
  }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
  ft = "python", -- Load when opening Python files
  keys = {
    { "<localleader>v", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
  },
  opts = { -- this can be an empty lua table - just showing below for clarity.
    search = {}, -- if you add your own searches, they go here.
    options = {
      picker = "snacks",
      picker_options = {
        snacks = {
          layout = {
            preset = "select",
          },
        },
      },
    },
  },
}
