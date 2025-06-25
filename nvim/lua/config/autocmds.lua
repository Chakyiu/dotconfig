-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- * --
--
-- * disable auto comment in newline
vim.cmd("autocmd bufenter * set formatoptions-=cro")
vim.cmd("autocmd bufenter * setlocal formatoptions-=cro")

-- * auto title
local function set_titlestring()
  local cwd = vim.fn.getcwd()
  local root_dir = vim.fn.fnamemodify(cwd, ":t")
  vim.opt.titlestring = "n " .. root_dir
  vim.opt.title = true
end

set_titlestring()
