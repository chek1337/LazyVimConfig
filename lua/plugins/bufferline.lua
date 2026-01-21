return {
  "akinsho/bufferline.nvim",
  priority = 100000,
  opts = {
    options = {
      right_mouse_command = false,
      middle_mouse_command = function(bufnum)
        vim.defer_fn(function()
          Snacks.bufdelete(bufnum)
        end, 100)
      end,
      always_show_bufferline = true,
      sort_by = "id",
      separator_style = "slant",
      indicator = {
        -- style = "underline", -- broken in tmux
      },
      hover = { -- ???
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
    },
  },
}
