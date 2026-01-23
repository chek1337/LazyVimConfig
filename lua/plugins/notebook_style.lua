return {
  "stellarjmr/notebook_style.nvim",
  ft = "python",
  opts = {
    border_style = "my_style",
    hide_border_in_insert = false,
    manual_render = false,
    colors = {
      border = "#585b70",
      delimiter = "#414162",
    },
    border_chars = {
      my_style = {
        top_left = "",
        top_right = "",
        bottom_left = "",
        bottom_right = "",
        horizontal = "━",
        vertical = "",
      },
    },
  },
}
