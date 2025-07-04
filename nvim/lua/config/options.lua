-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- * --
--
-- * Disable auto comment on next line
vim.opt.formatoptions:remove("cro")

-- * Use spaces instead of tab for indent
-- vim.opt.expandtab = true
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.softtabstop = 4

-- * enable fzf picker
vim.g.lazyvim_picker = "fzf"
