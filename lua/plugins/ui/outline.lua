-- NOTE: aerial outline plugin settings
local opts = {
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
}

return {
  "stevearc/aerial.nvim",
  event = "VeryLazy",
  config = function()
    require("aerial").setup(opts)
  end,
}
