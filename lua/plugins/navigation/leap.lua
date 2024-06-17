return {
  {
    "ggandor/leap.nvim",
    config = function()
      vim.keymap.set("n", "s", "<Plug>(leap-forward)")
      vim.keymap.set("n", "S", "<Plug>(leap-backward)")
      vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap-backward)")
      -- require("leap").opts.equivalence_classes = { " \t\r\n", "[{", "'\"", "]}" }
      vim.cmd("autocmd ColorScheme * lua require('leap').init_highlight(true)")
    end,
  },
  {
    "ggandor/flit.nvim",
    config = function()
      require("flit").setup({
        keys = { f = "f", F = "F", t = "t", T = "T" },
        labeled_modes = "v",
        multiline = false,
        opts = {
          equivalence_classes = { " \t\r\n", "[{", "'\"", "]}" },
        },
      })
    end,
  },
}
