return {
  "folke/snacks.nvim",
  opts = {
    -- snacks.nvim/lua/snacks/picker/config/layouts.lua
    picker = {
      layout = {
        layout = {
          backdrop = false,
          width = 0.95,
          min_width = 120,
          height = 0.99,
          border = "none",
          box = "vertical",
          -- Preview
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
      },
      sources = {
        explorer = {
          layout = {
            layout = {
              backdrop = false,
              width = 40,
              min_width = 40,
              height = 0,
              position = "left",
              border = "none",
              box = "vertical",
              {
                win = "input",
                height = 1,
                border = true,
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            },
          },
        },
      },
    },
  },
}
