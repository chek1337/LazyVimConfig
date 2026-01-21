-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/dap/core.lua

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "igorlfs/nvim-dap-view",
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          require("dap-python").setup("debugpy-adapter")
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },

    -- stylua: ignore
     keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue (F5)" },
      { "<F17>", function() require("dap").terminate() end, desc = "Debug: Stop (Shift+F5)" },
      { "<F41>", function() require("dap").restart() end, desc = "Debug: Restart (Ctrl+Shift+F5)" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint (F9)" },
      { "<F21>", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Debyg: Conditional Breakpoint (Shift + F9)" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over (F10)" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into (F11)" },
      {  "<F23>", function() require("dap").step_out() end, desc = "Debug: Step Out (Shift+F11)" },

      { "<F8>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down Stack" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up Stack" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      -- { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>dW", function() require("dap.ui.widgets").hover() end, desc = "Debug Widgets" },
    },

    config = function()
      -- load mason-nvim-dap here, after all adapters have been setup
      if LazyVim.has("mason-nvim-dap.nvim") then
        require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
      end

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      -- setup dap config by VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
    end,
  },
}
