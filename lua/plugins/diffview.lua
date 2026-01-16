return {
  "sindrets/diffview.nvim",
  opts = {
    file_panel = {
      listing_style = "tree",
      tree_options = {
        flatten_dirs = true,
        folder_statuses = "only_folded",
      },
      win_config = {
        type = "split",
        position = "bottom", -- ← главное изменение
        height = 10, -- подбери под свой экран
        win_opts = {},
      },
    },

    -- Чтобы diff занимал больше места — можно сделать layout вертикальным
    -- view = {
    --   default = {
    --     layout = "diff2_vertical", -- или оставить horizontal
    --   },
    --   merge_tool = {
    --     layout = "diff3_vertical",
    --   },
    -- },
  },
}
