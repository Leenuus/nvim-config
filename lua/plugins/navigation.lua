return {
  "tpope/vim-repeat",
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").create_default_mappings()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
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
}
