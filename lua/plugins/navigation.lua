return {
  "tpope/vim-repeat",
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").create_default_mappings()
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
    "kylechui/nvim-surround",
    version = "*",
    config = function()
      local keymap = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "0",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      }
      require("nvim-surround").setup({
        keymaps = keymap,
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
}
