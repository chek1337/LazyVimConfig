return {
  "folke/snacks.nvim",
  priority = 10,
  config = function()
    local opts = {
      dashboard = { enabled = true },
      picker = {
        layout = {
          preset = "dropdown",
        },
      },
    }
    require("snacks").setup(opts)
    local layouts = require("snacks.picker.config.layouts")
    layouts.dropdown = vim.tbl_deep_extend("force", layouts.dropdown, {
      layout = {
        backdrop = false,
        row = 0,
        width = 0.95,
        min_width = 120,
        height = 0.99,
        border = "none",
        box = "vertical",
        -- preview
        {
          win = "preview",
          title = "{preview}",
          height = 0.7,
          border = true,
        },
        {
          box = "vertical",
          border = true,
          title = "{title} {live} {flags}",
          title_pos = "center",
          { win = "input", height = 1, border = "bottom" },
          { win = "list", border = "none" },
        },
      },
    })
  end,
}

-- return { -- simple solution to change pickers
--   "folke/snacks.nvim",
--   opts = {
--     picker = {
--       layout = {
--         preset = "ivy_split", -- :help snacks-picker (9. Layouts)
--       },
--     },
--   },
-- }
