return {
  "GCBallesteros/jupytext.nvim",
  lazy = false,
  config = function()
    require("jupytext").setup({
      style = "percent",
      output_extension = "py",
      force_ft = "python",
    })
  end,
}
