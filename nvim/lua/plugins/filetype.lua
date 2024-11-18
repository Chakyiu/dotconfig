return {
  {
    "nathom/filetype.nvim",
    lazy = false,
    opts = {
      overrides = {
        extensions = {
          env = "env",
        },
        complex = {
          [".env.*"] = "env",
        },
      },
    },
  },
}
