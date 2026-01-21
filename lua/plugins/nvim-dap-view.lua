vim.g.dap_view_open = false

return {
  "igorlfs/nvim-dap-view",
  keys = {
    {
      "<leader>dd",
      function()
        if vim.g.dap_view_open then
          vim.cmd("DapViewClose!")
          vim.g.dap_view_open = false
        else
          vim.cmd("DapViewOpen")
          vim.g.dap_view_open = true
        end
      end,
      desc = "Debug: Toggle dap-view (open / close + term)",
    },
    {
      "<leader>dx",
      function()
        vim.cmd("DapViewClose!")
      end,
      desc = "Debug: Close dap-view force",
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
