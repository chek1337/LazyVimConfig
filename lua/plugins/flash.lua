return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    { "S", mode = { "n", "o", "x" }, false },
  },
  config = function()
    vim.keymap.set({ "n", "x", "o" }, "s", function()
      require("flash").jump({ search = { mode = "fuzzy" } })
    end, { desc = "Flash continue" })

    vim.keymap.set({ "n", "x", "o" }, "<M-w>", function()
      require("flash").jump({
        pattern = vim.fn.expand("<cword>"),
      })
    end, { desc = "Flash continue" })

    vim.keymap.set({ "n", "x", "o" }, "<M-l>", function()
      require("flash").jump({
        search = { mode = "search", max_length = 0 },
        label = { after = { 0, 0 } },
        pattern = "^",
      })
    end, { desc = "Flash continue" })

    vim.keymap.set({ "n", "x", "o" }, "<M-s>", function()
      require("flash").jump({
        pattern = ".", -- initialize pattern with any char
        search = {
          mode = function(pattern)
            -- remove leading dot
            if pattern:sub(1, 1) == "." then
              pattern = pattern:sub(2)
            end
            -- return word pattern and proper skip pattern
            return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
          end,
        },
        -- select the range
        -- jump = { pos = "range" },
      })
    end, { desc = "Flash continue" })
  end,
}
