return {
  "Vigemus/iron.nvim",
  config = function()
    local iron = require("iron.core")
    local view = require("iron.view")
    local common = require("iron.fts.common")

    iron.setup({
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          sh = {
            -- Can be a table or a function that
            -- returns a table (see below)
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

              print("Virtual environment activated: " .. venv_name)

              -- Start Python with a command to print the environment info
              return {
                "ipython",
                "--no-autoindent",
                "-c",
                "import sys; print('========== iron.nvim REPL =========='); print('Venv:', '"
                  .. venv_name
                  .. "'); print('Python:', sys.version.split()[0]); print('====================================')",
                "-i", -- Keep interactive mode after executing
              }
            end,

            -- https://github.com/g0t4/dotfiles/blob/1a7e5601553c0bcef6c4c9cc8578a0158efc42f5/.config/nvim/lua/plugins/terminals.lua#L564
            format = function(lines, extras)
              -- TLDR:
              --   I really like cell per line which effectively auto labels each print statement! with the full chunk of code
              --     really this is one statement per cell (i.e. functions act as wrappers)
              --     I do not really want to label my output manually every time
              --     bracketed_paste => runs entire selection as one chunk (so isf => all of file in one go is impossible to discren WTF is WHAT)
              --   ONLY nice to have would be to stop on the first failing line (cell)  when running multiple lines (cells)
              --   IF I want batched lines (not interleaved):
              --     I can use a function which is treated as one statement/line/cell
              --   TBH, it did take a second to get used to the interleaved code and lines but now I really, really like it
              -- result = require("iron.fts.common").bracketed_paste(lines, extras) -- everything selected is one cell (yuck)
              result = require("iron.fts.common").bracketed_paste_python(lines, extras) -- *** defacto is cell per line (yes)

              --  FYI I am unsure that bracketed_paste/bracketed_paste_python differences are intended so if they "fix" the way I like it, then I should add my own version

              -- remove lines that only contain a comment
              -- FYI I really like this with cell per line style! b/c it makes it more compact!!!
              filtered = vim.tbl_filter(function(line)
                return not string.match(line, "^%s*#")
              end, result)
              return filtered
            end,
            block_dividers = { "# %%", "#%%" },
            env = { PYTHON_BASIC_REPL = "1" }, --this is needed for python3.13 and up.
          },
        },
        -- set the file type of the newly created repl to ft
        -- bufnr is the buffer id of the REPL and ft is the filetype of the
        -- language being used for the REPL.
        repl_filetype = function(bufnr, ft)
          return ft
          -- or return a string name such as the following
          -- return "iron"
        end,
        -- Send selections to the DAP repl if an nvim-dap session is running.
        dap_integration = true,
        -- How the repl window will be displayed
        -- See below for more information
        -- repl_open_cmd = view.bottom(40),
        repl_open_cmd = view.split.vertical.rightbelow("%40"), -- cmd_1: open a repl to the right

        -- repl_open_cmd can also be an array-style table so that multiple
        -- repl_open_commands can be given.
        -- When repl_open_cmd is given as a table, the first command given will
        -- be the command that `IronRepl` initially toggles.
        -- Moreover, when repl_open_cmd is a table, each key will automatically
        -- be available as a keymap (see `keymaps` below) with the names
        -- toggle_repl_with_cmd_1, ..., toggle_repl_with_cmd_k
        -- For example,
        --
        -- repl_open_cmd = {
        --   view.split.vertical.rightbelow("%40"), -- cmd_1: open a repl to the right
        --   view.split.rightbelow("%25")  -- cmd_2: open a repl below
        -- }
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {
        toggle_repl = "<localleader>rr", -- toggles the repl open and closed.
        -- If repl_open_command is a table as above, then the following keymaps are
        -- available
        -- toggle_repl_with_cmd_1 = "<localleader>rv",
        -- toggle_repl_with_cmd_2 = "<localleader>rh",
        restart_repl = "<localleader>rR", -- calls `IronRestart` to restart the repl
        send_motion = "<localleader>sc",
        visual_send = "<localleader>sc",
        send_file = "<localleader>sf",
        send_line = "<localleader>sl",
        send_paragraph = "<localleader>sp",
        send_until_cursor = "<localleader>su",
        send_mark = "<localleader>sm",
        send_code_block = "<localleader>sb",
        send_code_block_and_move = "<localleader>sn",
        mark_motion = "<localleader>mc",
        mark_visual = "<localleader>mc",
        remove_mark = "<localleader>md",
        cr = "<localleader>s<cr>",
        interrupt = "<localleader>s<space>",
        exit = "<localleader>sq",
        clear = "<localleader>cl",
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    })

    -- iron also has a list of commands, see :h iron-commands for all available commands
    vim.keymap.set("n", "<localleader>rf", "<cmd>IronFocus<cr>")
    vim.keymap.set("n", "<localleader>rh", "<cmd>IronHide<cr>")

    --
  end,
}
