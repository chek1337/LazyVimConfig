return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "VeryLazy",
  keys = {
    {
      "gC",
      function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end,
      mode = "n",
      silent = true,
      desc = "Jump to context",
    },
    opts = {
      enable = true,
      mode = "cursor", -- 'cursor'/'topline'
    },
  },
}
