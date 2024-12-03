-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  -- theme plugins
  { import = "astrocommunity.colorscheme.catppuccin" },
  -- LSP plugins
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.prisma" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.xml" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.ps1" },
  { import = "astrocommunity.pack.proto" },
  { import = "astrocommunity.pack.svelte" },
  { import = "astrocommunity.pack.bash" },
  -- completion plugins
  { import = "astrocommunity.completion.copilot-cmp" },
  -- editing support plugins
  { import = "astrocommunity.editing-support.comment-box-nvim" },
  { import = "astrocommunity.editing-support.copilotchat-nvim" },
  -- code runner plugins
  { import = "astrocommunity.code-runner.overseer-nvim" },
  -- indent plugins
  { import = "astrocommunity.indent.mini-indentscope" },
  -- utility plugins
  { import = "astrocommunity.utility.lua-json5" },
  -- split and windows plugins
  { import = "astrocommunity.split-and-window.colorful-winsep-nvim" },
}
