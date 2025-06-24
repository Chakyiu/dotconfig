local wk = require("which-key")
wk.add({
  { "<leader>m", group = "+Map" },
})

return {
  {
    "echasnovski/mini.map",
    version = "*",
    keys = {
      {
        "<leader>mt",
        function()
          require("mini.map").toggle()
        end,
        desc = "Toggle minimap",
      },
      {
        "<leader>mf",
        function()
          require("mini.map").toggle_focus()
        end,
        desc = "Toggle minimap focus",
      },
      -- Add more keymaps as needed
    },
    config = function()
      local diagnostic_integration = require("mini.map").gen_integration.diagnostic({
        error = "DiagnosticFloatingError", -- Color for errors
        warn = "DiagnosticFloatingWarn", -- Color for warnings
        info = "DiagnosticFloatingInfo", -- Color for info
        hint = "DiagnosticFloatingHint", -- Color for hints
      })

      require("mini.map").setup({
        integrations = {
          require("mini.map").gen_integration.builtin_search(),
          diagnostic_integration,
        }, -- or add your integrations here
        symbols = {
          encode = nil, -- default is 3x2 solid blocks
          scroll_line = "█",
          scroll_view = "┃",
        },
        window = {
          focusable = false,
          side = "right",
          show_integration_count = true,
          width = 10,
          winblend = 25,
          zindex = 10,
        },
      })
    end,
  },
}
