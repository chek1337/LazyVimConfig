return {
  "Vigemus/iron.nvim",
  config = function()
    local iron = require("iron.core")
    local view = require("iron.view")
    local common = require("iron.fts.common")

    local screen_w = vim.opt.columns:get()
    local screen_h = vim.opt.lines:get()
    local cmdheight = vim.opt.cmdheight:get()

    iron.setup({
      config = {
        scratch_repl = true,
        repl_definition = {
          sh = {
            command = { "zsh" },
          },
          python = {
            command = function()
              local venv_path = require("venv-selector").venv()
              local venv_name = ""

              if venv_path and venv_path ~= "" then
                venv_name = vim.fn.fnamemodify(venv_path, ":t")
              else
                venv_name = "Global Python"
              end
              -- print("Virtual environment activated: " .. venv_name)
              return {
                "ipython",
                "--no-autoindent",
                "-c",
                "import sys; print('========================= iron.nvim REPL =========================='); print('Venv:', '"
                  .. venv_name
                  .. "'); print('Python:', sys.version.split()[0]); print('===================================================================')",
                "-i", -- Keep interactive mode after executing
              }
            end,

            format = function(lines, extras)
              result = require("iron.fts.common").bracketed_paste_python(lines, extras)
              filtered = vim.tbl_filter(function(line)
                return not string.match(line, "^%s*#")
              end, result)
              return filtered
            end,
            block_dividers = { "# %%", "#%%" },
            env = { PYTHON_BASIC_REPL = "1" },
          },
        },
        repl_filetype = function(bufnr, ft)
          return ft
        end,
        dap_integration = true,

        repl_open_cmd = {
          view.right("40%"),
          view.offset({
            width = screen_w - 16,
            height = screen_h - 1,
            w_offset = 8,
            h_offset = view.helpers.flip(1),
          }),
          view.offset({
            width = "100%",
            height = "25%",
            w_offset = 0,
            h_offset = view.helpers.flip(1),
          }),
        },
      },
      keymaps = {
        toggle_repl_with_cmd_1 = "<localleader>rr", -- default fast open
        toggle_repl_with_cmd_2 = "<localleader>re", --  "extended"
        toggle_repl_with_cmd_3 = "<localleader>rd", -- "down""
        restart_repl = "<localleader>rR",
        send_motion = "<localleader>sc",
        visual_send = "<localleader>ss",
        send_file = "<localleader>sf",
        send_line = "<localleader>sl",
        send_paragraph = "<localleader>sp",
        send_until_cursor = "<localleader>su",
        send_mark = "<localleader>sm",
        send_code_block = "<localleader>ss",
        send_code_block_and_move = "<localleader>sa",
        mark_motion = "<localleader>mc",
        mark_visual = "<localleader>mc",
        remove_mark = "<localleader>md",
        cr = "<localleader>s<cr>",
        interrupt = "<localleader>s<localleader>",
        exit = "<localleader>sq",
        clear = "<localleader>cl",
      },
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true,
    })
  end,
}
