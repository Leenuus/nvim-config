return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      pcall(require("telescope").load_extension, "fzf")
      return vim.fn.executable("make") == 1
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("config.tele")
    end,
  },
}
