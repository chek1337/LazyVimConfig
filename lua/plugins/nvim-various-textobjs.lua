return {
  "chrisgrieser/nvim-various-textobjs",
  event = "VeryLazy",
  opts = {
    keymaps = {
      useDefaults = true,
    },
  },
  config = function(_, opts)
    require("various-textobjs").setup(opts)
    vim.keymap.set({ "o", "x" }, "gR", function()
      require("various-textobjs").restOfIndentation()
    end, { desc = "restOfIndentation textobj" })
  end,
}
