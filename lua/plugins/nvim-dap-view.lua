return {
  "igorlfs/nvim-dap-view",
    -- stylua: ignore
    keys = {
      {
        "<leader>dd", 
        function()
          local view = require("dap-view")
          -- Проверяем, существует ли и видим ли хотя бы один из окон плагина
          local wins = vim.api.nvim_list_wins()
          local has_view = false

          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            local name = vim.api.nvim_buf_get_name(buf)
            if name:match("dap%-view") or name:match("dap%-console") then
              has_view = true
              break
            end
          end

          if has_view then
            view.close({ bang = true })
          else
            view.open()
          end
        end,
        desc = "Debug: Toggle dap-view (open / close + term)",
      },
      { "<leader>dw", "<Cmd>DapViewWatch<CR>", desc = "Debug: Add Variable to Scope" },
    },
  opts = {
    winbar = {
      sections = { "watches", "scopes", "breakpoints", "repl", "exceptions", "threads", "sessions" },
      controls = {
        enabled = true,
        position = "right",
      },
    },
    windows = {
      size = 0.35,
      position = "below",
      terminal = {
        size = 0.4,
        position = "right",
      },
    },
    auto_toggle = false,
  },
}
