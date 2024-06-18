local actions = require("telescope.actions")

local opener = function(direction)
  return function(p)
    local old = vim.o.splitbelow
    local old1 = vim.o.splitright
    if direction == "left" then
      vim.o.splitright = false
      actions.select_vertical(p)
    elseif direction == "right" then
      vim.o.splitright = true
      actions.select_vertical(p)
    elseif direction == "above" then
      vim.o.splitbelow = false
      actions.select_horizontal(p)
    elseif direction == "below" then
      vim.o.splitbelow = true
      actions.select_horizontal(p)
    else
      actions.select_default(p)
    end
    vim.o.splitbelow = old
    vim.o.splitright = old1
  end
end

require("telescope").setup({
  defaults = {
    -- TODO: center results, smaller window width, and disable previewer, toggle previewer bindings
    layout_strategy = "vertical",
    mappings = {
      n = {
        ["<Tab>"] = actions.toggle_selection,
        ["\\"] = actions.select_vertical,
        ["-"] = actions.select_horizontal,
        ["t"] = actions.select_tab,
        ["T"] = actions.select_tab,
        ["J"] = opener("below"),
        ["K"] = opener("above"),
        ["H"] = opener("left"),
        ["L"] = opener("right"),
        ["q"] = actions.close,
        ["<Left>"] = actions.cycle_history_prev,
        ["<Right>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<Down>"] = actions.cycle_history_next,
      },
      i = {
        ["<Left>"] = actions.cycle_history_prev,
        ["<Right>"] = actions.cycle_history_next,
        ["<C-T>"] = actions.select_tab,
        ["<Tab>"] = actions.select_tab,
        ["<C-P>"] = actions.select_tab,
        ["<C-J>"] = opener("below"),
        ["<C-K>"] = opener("above"),
        ["<C-H>"] = opener("left"),
        ["<C-L>"] = opener("right"),
        ["<C-D>"] = actions.preview_scrolling_down,
        ["<C-U>"] = actions.preview_scrolling_up,
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
    project = {
      base_dirs = {
        { "~/Projects",               max_depth = 1 },
        { "~/.local/share/nvim/lazy", max_depth = 1 },
      },
      hidden_files = false,
      theme = "dropdown",
      order_by = "asc",
      search_by = "title",
      sync_with_nvim_tree = false,
      on_project_selected = function(prompt_bufnr)
        local p_actions = require("telescope._extensions.project.actions")
        p_actions.change_working_directory(prompt_bufnr)
        vim.cmd("QuickFiles")
      end,
    },
  },
})
