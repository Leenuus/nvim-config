local opts = {
  timeout = 3000,
  max_height = function()
    return math.floor(vim.o.lines * 0.75)
  end,
  max_width = function()
    return math.floor(vim.o.columns * 0.3)
  end,
  on_open = function(win)
    vim.api.nvim_win_set_config(win, { zindex = 100 })
  end,
}

return {
  "nvim-telescope/telescope-ui-select.nvim",
  config = function()
    pcall(require("telescope").load_extension, "ui-select")
  end,
  {
    "MunifTanjim/nui.nvim",
    config = function()
      -- require('nui')
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup(opts)
    end,
  },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        input = {
          -- Set to false to disable the vim.ui.input implementation
          enabled = true,
          default_prompt = "Input",
          trim_prompt = true,
          -- Can be 'left', 'right', or 'center'
          title_pos = "center",
          -- When true, <Esc> will close the modal
          insert_only = true,
          -- When true, input will start in insert mode.
          start_in_insert = true,
          -- These are passed to nvim_open_win
          border = "rounded",
          -- 'editor' and 'win' will default to being centered
          relative = "editor",
          -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          prefer_width = 50,
          width = nil,
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },
          buf_options = {},
          win_options = {
            -- Disable line wrapping
            wrap = false,
            -- Indicator for when text exceeds window
            list = true,
            listchars = "precedes:…,extends:…",
            -- Increase this for more context when text scrolls off the window
            sidescrolloff = 0,
          },

          -- Set to `false` to disable
          mappings = {
            n = {
              ["<Esc>"] = "Close",
              ["<CR>"] = "Confirm",
            },
            i = {
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
              ["<Up>"] = "HistoryPrev",
              ["<Down>"] = "HistoryNext",
            },
          },
          override = function(conf)
            return conf
          end,
          -- see :help dressing_get_config
          get_config = nil,
        },
        select = {
          -- Set to false to disable the vim.ui.select implementation
          enabled = false,
        },
      })
    end,
  },
}
