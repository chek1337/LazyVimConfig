-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/dap/core.lua

---@param config {type?:string, args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
  local args_str = type(args) == "table" and table.concat(args, " ") or args --[[@as string]]

  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) --[[@as string]]
    if config.type and config.type == "java" then
      ---@diagnostic disable-next-line: return-type-mismatch
      return new_args
    end
    return require("dap.utils").splitstr(new_args)
  end
  return config
end

local float_params = {
  width = 100,
  height = 100,
  enter = true,
  position = "center",
}

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "igorlfs/nvim-dap-view",
      {
        "mfussenegger/nvim-dap-python",
        -- stylua: ignore
        keys = {
        -- { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
        -- { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
      },
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
      { "<S-F5>", function() require("dap").terminate() end, desc = "Debug: Stop (Shift+F5)" },
      { "<C-S-F5>", function() require("dap").restart() end, desc = "Debug: Restart (Ctrl+Shift+F5)" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint (F9)" },
      { "<S-F9>", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Conditional Breakpoint" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over (F10)" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into (F11)" },
      { "<S-F11>", function() require("dap").step_out() end, desc = "Debug: Step Out (Shift+F11)" },

      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down Stack" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up Stack" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
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

  {
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
      auto_toggle = true,
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "x"} },
      { "<leader>dfs",
        function()
          require("dapui").float_element("scopes", float_params) 
        end, 
        desc = "Open Floating Scopes", mode = {"n", "x"} },
      { "<leader>dfS",
        function()
          require("dapui").float_element("stacks", float_params) 
        end, 
        desc = "Open Floating Stacks", mode = {"n", "x"} },
      { "<leader>dfw",
        function()
          require("dapui").float_element("watches", float_params) 
        end, 
        desc = "Open Floating Watches", mode = {"n", "x"} },
      { "<leader>dfb",
        function()
          require("dapui").float_element("breakpoints", float_params) 
        end, 
        desc = "Open Floating Breakpoints", mode = {"n", "x"} },
      { "<leader>dfr",
        function()
          require("dapui").float_element("repl", float_params) 
        end, 
        desc = "Open Floating Repl", mode = {"n", "x"} },
      { "<leader>dfc",
        function()
          require("dapui").float_element("console", float_params) 
        end, 
        desc = "Open Floating Console", mode = {"n", "x"} },
    },
    opts = {
      layouts = {
        {
          -- You can change the order of elements in the sidebar
          elements = {
            -- Provide IDs as strings or tables with "id" and "size" keys
            {
              id = "scopes",
              size = 0.25, -- Can be float or integer > 1
            },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left", -- Can be "left" or "right"
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 10,
          position = "bottom", -- Can be "bottom" or "top"
        },
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      automatic_installation = true,
      handlers = {
        python = function() end,
      },
    },
  },
}
