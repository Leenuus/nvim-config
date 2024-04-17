return {
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  {
    -- extension for easily creating abbr
    "tpope/vim-abolish",
  },
  -- Useful plugin to show you pending keybinds.
  { "folke/which-key.nvim",  event = "VeryLazy", opts = {} },
  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    -- See `:help lualine.txt`
    enabled = true,
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "|",
        section_separators = "",
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = "ibl",
    lazy = true,
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
  {
    "keaising/im-select.nvim",
    config = function()
      require("im_select").setup({})
    end,
  },
}
