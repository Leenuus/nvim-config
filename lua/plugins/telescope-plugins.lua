return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            n = {
              ["<Tab>"] = actions.toggle_selection,
              ["\\"] = actions.select_vertical,
              ["-"] = actions.select_horizontal,
            },
            i = {
              ["<C-P>"] = actions.select_vertical,
              ["<C-S>"] = actions.select_horizontal,
            },
          },
        },
        pickers = {
          lsp_references = {
            theme = "dropdown",
            initial_mode = "normal",
          },

          lsp_definitions = {
            theme = "dropdown",
            initial_mode = "normal",
          },

          lsp_declarations = {
            theme = "dropdown",
            initial_mode = "normal",
          },

          lsp_implementations = {
            theme = "dropdown",
            initial_mode = "normal",
          },

          colorscheme = {
            enable_preview = true,
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      pcall(require("telescope").load_extension, "fzf")
      return vim.fn.executable("make") == 1
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    dir = "~/Projects/Neovims/mpc.nvim",
    enabled = false,
    config = function()
      require("telescope").load_extension("mpc")
    end,
  },
}
