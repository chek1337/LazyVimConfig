return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  opts = {
    file_panel = {
      listing_style = "tree",
      tree_options = {
        flatten_dirs = true,
        folder_statuses = "only_folded",
      },
      win_config = {
        type = "split",
        position = "bottom",
        height = 10,
        win_opts = {},
      },
    },
  },

  keys = {
    { "<leader>gd", ":DiffviewOpen<CR>", silent = true, desc = "Open Diffview" },
    { "<leader>gf", ":DiffviewFileHistory %<CR>", silent = true, desc = "File History" },
    { "<leader>gq", ":DiffviewClose<CR>", silent = true, desc = "Close Diffview" },
    {
      "<leader>gD",
      function()
        vim.fn.feedkeys(":DiffviewOpen ", "n")
      end,
      desc = "DiffviewOpen Motion",
    },
  },
}
