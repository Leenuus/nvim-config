return {
  "tpope/vim-repeat",
  {
    "ggandor/leap.nvim",
    config = function()
      vim.keymap.set("n", "s", "<Plug>(leap)")
      vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
      vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap-backward)")
      require("leap").opts.equivalence_classes = { " \t\r\n", "([{ )]}", "'\"`" }
      vim.cmd("autocmd ColorScheme * lua require('leap').init_highlight(true)")
    end,
  },
  {
    "ggandor/flit.nvim",
    config = function()
      require("flit").setup({
        keys = { f = "f", F = "F", t = "t", T = "T" },
        -- A string like "nv", "nvo", "o", etc.
        labeled_modes = "v",
        multiline = false,
        -- Like `leap`s similar argument (call-specific overrides).
        -- E.g.: opts = { equivalence_classes = {} }
        opts = {},
      })
    end,
  },
  {
    dir = "~/Projects/Neovims/nvim-tmux-navigator",
    config = function()
      require("neovim-tmux-navigator").setup({
        use_default_keymap = true,
        cross_win = true,
        pane_nowrap = true,
      })
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      auto_close = true,
      position = "left",                    -- position of the list can be: bottom, top, left, right
      mode = "workspace_diagnostics",       -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
      action_keys = {                       -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        close = "q",                        -- close the list
        cancel = "<esc>",                   -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r",                      -- manually refresh
        jump = { "<cr>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
        open_split = { "<c-s>" },           -- open buffer in new split
        open_vsplit = { "<c-p>" },          -- open buffer in new vsplit
        open_tab = { "<c-t>" },             -- open buffer in new tab
        jump_close = { "o" },               -- jump to the diagnostic and close the list
        toggle_mode = "m",                  -- toggle between "workspace" and "document" diagnostics mode
        switch_severity = "s",              -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
        toggle_preview = "P",               -- toggle auto_preview
        hover = {},                         -- opens a small popup with the full multiline message
        preview = "p",                      -- preview the diagnostic location
        open_code_href = "c",               -- if present, open a URI with more information about the diagnostic error
        close_folds = { "zM", "zm" },       -- close all folds
        open_folds = { "zR", "zr" },        -- open all folds
        toggle_fold = { "zA", "za" },       -- toggle fold of current file
        previous = "k",                     -- previous item
        next = "j",                         -- next item
        help = "?",                         -- help menu
      },
    },
  },

  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup({
        -- Priority list of preferred backends for aerial.
        -- This can be a filetype map (see :help aerial-filetype-map)
        backends = { "treesitter", "lsp", "markdown", "man" },

        layout = {
          -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
          -- max_width = { 40, 0.3 },
          -- width = 0.4,
          min_width = 0.25,

          -- key-value pairs of window-local options for aerial window (e.g. winhl)
          win_opts = {},

          -- Determines the default direction to open the aerial window. The 'prefer'
          -- options will open the window in the other direction *if* there is a
          -- different buffer in the way of the preferred direction
          -- Enum: prefer_right, prefer_left, right, left, float
          default_direction = "prefer_left",

          -- Determines where the aerial window will be opened
          --   edge   - open aerial at the far right/left of the editor
          --   window - open aerial to the right/left of the current window
          placement = "window",

          -- When the symbols change, resize the aerial window (within min/max constraints) to fit
          resize_to_content = false,

          -- Preserve window size equality with (:help CTRL-W_=)
          preserve_equality = false,
        },

        -- Determines how the aerial window decides which buffer to display symbols for
        --   window - aerial window will display symbols for the buffer in the window from which it was opened
        --   global - aerial window will display symbols for the current window
        attach_mode = "window",

        -- List of enum values that configure when to auto-close the aerial window
        --   unfocus       - close aerial when you leave the original source window
        --   switch_buffer - close aerial when you change buffers in the source window
        --   unsupported   - close aerial when attaching to a buffer that has no symbol source
        close_automatic_events = {},

        -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("aerial.actions").<name>
        -- Set to `false` to remove a keymap
        keymaps = {
          ["?"] = "actions.show_help",
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.jump",
          ["<2-LeftMouse>"] = "actions.jump",
          ["<C-p>"] = "actions.jump_vsplit",
          ["<C-s>"] = "actions.jump_split",
          ["p"] = false,
          ["<C-j>"] = "actions.down_and_scroll",
          ["<C-k>"] = "actions.up_and_scroll",
          ["{"] = "actions.prev",
          ["}"] = "actions.next",
          ["[["] = "actions.prev_up",
          ["]]"] = "actions.next_up",
          ["q"] = "actions.close",
          ["o"] = "actions.tree_toggle",
          ["za"] = "actions.tree_toggle",
          ["O"] = "actions.tree_toggle_recursive",
          ["zA"] = "actions.tree_toggle_recursive",
          ["l"] = "actions.tree_open",
          ["zo"] = "actions.tree_open",
          ["L"] = "actions.tree_open_recursive",
          ["zO"] = "actions.tree_open_recursive",
          ["h"] = "actions.tree_close",
          ["zc"] = "actions.tree_close",
          ["H"] = "actions.tree_close_recursive",
          ["zC"] = "actions.tree_close_recursive",
          ["zr"] = "actions.tree_increase_fold_level",
          ["zR"] = "actions.tree_open_all",
          ["zm"] = "actions.tree_decrease_fold_level",
          ["zM"] = "actions.tree_close_all",
          ["zx"] = "actions.tree_sync_folds",
          ["zX"] = "actions.tree_sync_folds",
        },
      })
    end,
  },
}
