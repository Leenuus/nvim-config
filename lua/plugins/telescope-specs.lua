return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local actions = require("telescope.actions")
      local state = require("telescope.actions.state")
      local log = require("plenary.log")

      require("telescope").setup({
        defaults = {
          mappings = {
            n = {
              ["<Tab>"] = actions.toggle_selection,
              ["\\"] = actions.select_vertical,
              ["-"] = actions.select_horizontal,
              ["'"] = actions.select_tab,
              ["<Left>"] = actions.cycle_history_prev,
              ["<Right>"] = actions.cycle_history_next,
              ["<Up>"] = actions.cycle_history_prev,
              ["<Down>"] = actions.cycle_history_next,
            },
            i = {
              ["<C-P>"] = actions.select_vertical,
              ["<C-S>"] = actions.select_horizontal,
              ["<C-t>"] = actions.select_tab,
              ["<C-J>"] = actions.preview_scrolling_down,
              ["<C-K>"] = actions.preview_scrolling_up,
              ["<Left>"] = actions.cycle_history_prev,
              ["<Right>"] = actions.cycle_history_next,
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
            theme = "dropdown",
            enable_preview = true,
          },

          find_files = {
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
}
