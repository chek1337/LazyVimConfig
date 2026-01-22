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
}
