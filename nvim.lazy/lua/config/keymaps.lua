-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- increase window height/ width
vim.keymap.set("n", "<C-w>", "<C-w>+", { noremap = true })
vim.keymap.set("n", "<C-s>", "<C-w>-", { noremap = true })
vim.keymap.set("n", "<C-a>", "<C-w><", { noremap = true })
vim.keymap.set("n", "<C-d>", "<C-w>>", { noremap = true })

changeNormalMode = function()
  vim.cmd("stopinsert")
end

vim.keymap.set("t", "<esc><esc>", changeNormalMode, { noremap = true })
