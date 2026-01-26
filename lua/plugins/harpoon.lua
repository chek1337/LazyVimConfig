return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true,
  opts = {
    settings = {
      save_on_toggle = true,
      sync_on_ui_close = true,
    },
  },
  keys = function()
    local harpoon = require("harpoon")
    --stylua: ignore
    local keys = {
      { "<leader>ha", function() harpoon:list():add() end, desc = "Add current file to Harpoon" },
      { "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon quick menu" },
      { "<leader>hd", function() harpoon:list():remove() end, desc = "Remove current file from Harpoon" } ,
      { "[g", function() harpoon:list():prev() end, desc = "Prev Harpoon File" } ,
      { "]g", function() harpoon:list():next() end, desc = "Next Harpoon File" } ,
    }

    for i = 1, 9 do
      table.insert(keys, {
        "<leader>" .. i,
        function()
          harpoon:list():select(i)
        end,
        desc = "which_key_ignore",
      })
      table.insert(keys, {
        "<leader>h" .. i,
        function()
          harpoon:list():select(i)
        end,
        --stylua: ignore
        desc = "Harpoon to File " .. i .. " (\"<leader>" .. i .. "\")",
      })
      table.insert(keys, {
        "<leader>hd" .. i,
        function()
          local l = harpoon:list():length()
          harpoon:list():remove_at(i)
          for j = i + 1, l do
            local item = harpoon:list():get(j)
            harpoon:list():replace_at(j - 1, item)
          end
        end,
        desc = "Harpoon Remove File " .. i,
      })
    end

    return keys
  end,
}
