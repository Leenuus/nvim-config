local opts = {
  modes = { insert = true, command = false, terminal = false },
  mappings = {
    ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
    ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
    ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

    [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
    ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
    ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

    ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
    ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
    ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
  },
}

return {
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    version = "*",
    config = function()
      require("helpers").toggler("minipairs_disable", "MiniPair", false, true)

      vim.api.nvim_create_autocmd("RecordingEnter", {
        callback = function()
          vim.cmd("MiniPairDisable")
        end,
      })

      require("mini.pairs").setup(opts)
    end,
  },
  {
    "tpope/vim-surround",
    init = function()
      vim.g.surround_no_mappings = 1
    end,
  },
  {
    "wellle/targets.vim",
    init = function()
      vim.g.targets_nl = "jk"
    end,
  },
}
