return {
  "folke/snacks.nvim",
  priority = 10,
  config = function()
    local opts = {
      dashboard = {
        enabled = true,
        preset = {
          -- https://github.com/MaximilianLloyd/ascii.nvim/blob/master/lua/ascii/text/neovim.lua
          header = [[

                                                                    
      ████ ██████           █████      ██                     
     ███████████             █████                             
     █████████ ███████████████████ ███   ███████████   
    █████████  ███    █████████████ █████ ██████████████   
   █████████ ██████████ █████████ █████ █████ ████ █████   
 ███████████ ███    ███ █████████ █████ █████ ████ █████  
██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        },
        sections = {
          { section = "header" },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
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
        row = 0,
        width = 0.95,
        min_width = 120,
        height = 0.99,
        {
          height = 0.7,
        },
      },
    })
    layouts.select = vim.tbl_deep_extend("force", layouts.select, {
      layout = {
        width = 0.95,
        min_width = 120,
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
