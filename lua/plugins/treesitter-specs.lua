local function enabled_p()
  return vim.env["tse"] ~= "0"
end

return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
    enabled = enabled_p,
  },
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    enabled = enabled_p,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = enabled_p,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("config.tree")
    end,
    enabled = enabled_p,
  },
}
