-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode with jj" })
vim.keymap.set({ "n", "v" }, "q", "<Nop>", { desc = "Disable macros completely" })

vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

vim.keymap.set({ "n", "v" }, "x", '"_x')

vim.keymap.set("n", "<leader>udd", function()
  local cfg = vim.diagnostic.config()
  local virt = cfg.virtual_lines

  if type(virt) == "table" and virt.current_line then
    -- Если уже включен режим только текущей линии - выключаем
    vim.diagnostic.config({ virtual_lines = false })
  else
    -- Иначе включаем режим только текущей линии
    vim.diagnostic.config({ virtual_lines = { current_line = true } })
  end
end, { desc = "Toggle virtual lines for current line only" })

vim.keymap.set("n", "<leader>udD", function()
  local cfg = vim.diagnostic.config()
  local virt = cfg.virtual_lines

  if virt == true or (type(virt) == "table" and not virt.current_line) then
    -- Если уже включена полная диагностика - выключаем
    vim.diagnostic.config({ virtual_lines = false })
  else
    -- Иначе включаем полную диагностику
    vim.diagnostic.config({ virtual_lines = true })
  end
end, { desc = "Toggle full virtual lines" })

-- vim.keymap.set("n", "<leader>udd", function()
--   local cfg = vim.diagnostic.config()
--   local virt = cfg.virtual_lines
--   if not virt then
--     vim.diagnostic.config({ virtual_lines = { current_line = true } })
--   elseif type(virt) == "table" and virt.current_line then
--     vim.diagnostic.config({ virtual_lines = true })
--   else
--     vim.diagnostic.config({ virtual_lines = false })
--   end
-- end, { desc = "Cycle virtual_lines modes" })
