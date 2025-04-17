-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- * --
--
-- * keymap <leader>bc to call command CopyRelativePath
vim.keymap.set("n", "<leader>bc", ":CopyRelativePath<CR>", { desc = "Copy relative path" })
