-- * Keymaps for copying file paths
local wk = require("which-key")

wk.add({
  -- Group label for <leader>cp
  { "<leader>cp", group = "Copy Path" },

  -- Individual mappings under the group
  {
    "<leader>cpp",
    function()
      vim.fn.setreg("+", vim.fn.expand("%:p"))
      print("Copied full path: " .. vim.fn.expand("%:p"))
    end,
    desc = "Copy full file path",
  },
  {
    "<leader>cpr",
    function()
      vim.fn.setreg("+", vim.fn.expand("%"))
      print("Copied relative path: " .. vim.fn.expand("%"))
    end,
    desc = "Copy relative file path",
  },
})
