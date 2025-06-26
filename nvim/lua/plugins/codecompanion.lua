local mapping_key_prefix = vim.g.ai_prefix_key or "<leader>a"

local PROMPTS = require("plugins.code-companion.prompts")

return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { mapping_key_prefix, group = "AI Code Companion", mode = { "n", "v" } },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "yaml", "markdown" } },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    opts = {
      render_modes = true, -- Render in ALL modes
      sign = {
        enabled = false, -- Turn off in the status column
      },
    },
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.animate = { enabled = false }
      opts.right = {
        {
          ft = "codecompanion",
          title = "Companion Chat",
          size = { width = 70 },
        },
      }
    end,
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup({
        port = 37373,
        config = os.getenv("HOME") .. "/.config/nvim/mcpservers.json",
        log = {
          level = vim.log.levels.WARN,
          to_file = true, -- ~/.local/state/nvim/mcphub.log
        },
        on_ready = function()
          vim.notify("MCP Hub is ready!", vim.log.levels.INFO, { title = "MCP Hub" })
        end,
      })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ibhagwan/fzf-lua",
      "MeanderingProgrammer/render-markdown.nvim",
      "folke/edgy.nvim",
      "ravitemer/mcphub.nvim",
    },
    opts = {
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
      },
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-sonnet-4",
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "copilot",
          roles = {
            llm = function(adapter)
              local model_name = ""
              if adapter.schema and adapter.schema.model and adapter.schema.model.default then
                local model = adapter.schema.model.default
                if type(model) == "function" then
                  model = model(adapter)
                end
                model_name = "(" .. model .. ")"
              end
              return "  " .. adapter.formatted_name .. model_name
            end,
            user = " User",
          },
          -- tools = {
          --   ["mcp"] = {
          --     callback = function()
          --       return require("mcphub.extensions.codecompanion")
          --     end,
          --     description = "Call tools and resources from the MCP Servers",
          --     opts = {
          --       required_approval = true,
          --     },
          --   },
          -- },
          slash_commands = {
            ["buffer"] = {
              callback = "strategies.chat.slash_commands.buffer",
              description = "Insert open buffers",
              opts = {
                contains_code = true,
                provider = "fzf_lua", -- default|telescope|mini_pick|fzf_lua
              },
            },
            ["file"] = {
              callback = "strategies.chat.slash_commands.file",
              description = "Insert a file",
              opts = {
                contains_code = true,
                max_lines = 1000,
                provider = "fzf_lua", -- telescope|mini_pick|fzf_lua
              },
            },
          },
          keymaps = {
            send = {
              callback = function(chat)
                vim.cmd("stopinsert")
                chat:submit()
                chat:add_buf_message({ role = "llm", content = "" })
              end,
              index = 1,
              description = "Send",
            },
            toggle = {
              modes = {
                n = "q",
              },
              index = 3,
              callback = function()
                vim.cmd("CodeCompanionChat Toggle")
              end,
              description = "Toggle Chat",
            },
            close = {
              modes = {
                n = "Q",
              },
              index = 3,
              callback = "keymaps.close",
              description = "Close Chat",
            },
            stop = {
              modes = {
                n = "<C-c>",
              },
              index = 4,
              callback = "keymaps.stop",
              description = "Stop Request",
            },
          },
        },
        inline = { adapter = "copilot" },
        agent = { adapter = "copilot" },
      },
      inline = {
        layout = "buffer", -- vertical|horizontal|buffer
      },
      display = {
        chat = {
          -- Change to true to show the current model
          show_settings = false,
          window = {
            layout = "vertical", -- float|vertical|horizontal|buffer
          },
        },
      },
      opts = {
        log_level = "DEBUG",
        system_prompt = PROMPTS.SYSTEM_PROMPT,
      },
      prompt_library = PROMPTS.PROMPT_LIBRARY,
    },
    keys = {
      -- Recommend setup
      {
        mapping_key_prefix .. "p",
        "<cmd>CodeCompanionActions<cr>",
        desc = "Code Companion - Prompt Actions",
      },
      {
        mapping_key_prefix .. "a",
        function()
          vim.cmd("CodeCompanionChat Toggle")
          vim.cmd("startinsert")
        end,
        desc = "Code Companion - Toggle",
        mode = { "n", "v" },
      },
      -- Some common usages with visual mode
      {
        mapping_key_prefix .. "e",
        "<cmd>CodeCompanion /explain<cr>",
        desc = "Code Companion - Explain code",
        mode = "v",
      },
      {
        mapping_key_prefix .. "E",
        "<cmd>CodeCompanion /english<cr>",
        desc = "Code Companion - English Review",
        mode = "v",
      },
      {
        mapping_key_prefix .. "f",
        "<cmd>CodeCompanion /fix<cr>",
        desc = "Code Companion - Fix code",
        mode = "v",
      },
      {
        mapping_key_prefix .. "l",
        "<cmd>CodeCompanion /lsp<cr>",
        desc = "Code Companion - Explain LSP diagnostic",
        mode = { "n", "v" },
      },
      {
        mapping_key_prefix .. "t",
        "<cmd>CodeCompanion /tests<cr>",
        desc = "Code Companion - Generate unit test",
        mode = "v",
      },
      {
        mapping_key_prefix .. "m",
        "<cmd>CodeCompanion /commit<cr>",
        desc = "Code Companion - Git commit message",
      },
      -- Custom prompts
      {
        mapping_key_prefix .. "M",
        "<cmd>CodeCompanion /staged-commit<cr>",
        desc = "Code Companion - Git commit message (staged)",
      },
      {
        mapping_key_prefix .. "d",
        "<cmd>CodeCompanion /inline-doc<cr>",
        desc = "Code Companion - Inline document code",
        mode = "v",
      },
      { mapping_key_prefix .. "D", "<cmd>CodeCompanion /doc<cr>", desc = "Code Companion - Document code", mode = "v" },
      {
        mapping_key_prefix .. "r",
        "<cmd>CodeCompanion /refactor<cr>",
        desc = "Code Companion - Refactor code",
        mode = "v",
      },
      {
        mapping_key_prefix .. "R",
        "<cmd>CodeCompanion /review<cr>",
        desc = "Code Companion - Review code",
        mode = "v",
      },
      {
        mapping_key_prefix .. "n",
        "<cmd>CodeCompanion /naming<cr>",
        desc = "Code Companion - Better naming",
        mode = "v",
      },
      -- Quick chat
      {
        mapping_key_prefix .. "q",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            vim.cmd("CodeCompanion " .. input)
          end
        end,
        desc = "Code Companion - Quick chat",
      },
    },
    config = function(_, opts)
      local spinner = require("plugins.code-companion.spinner")
      spinner:init()

      -- Setup the entire opts table
      require("codecompanion").setup(opts)
    end,
  },
}
