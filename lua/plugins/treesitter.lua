return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  "nvim-treesitter/nvim-treesitter-refactor",
  "nvim-treesitter/nvim-treesitter-context",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("tree")
    end,
  },
}
