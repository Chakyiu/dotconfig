-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

local function set_titlestring()
  local cwd = vim.fn.getcwd()
  local root_dir = vim.fn.fnamemodify(cwd, ":t")
  vim.opt.titlestring = "nvim " .. root_dir
  vim.opt.title = true
end

set_titlestring()
