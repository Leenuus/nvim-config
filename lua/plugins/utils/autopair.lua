local opts = {
  modes = { insert = true, command = false, terminal = false },
  mappings = {
    ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\][%s]" },
    ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\][%s]" },
    ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\][%s]" },

    [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
    ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
    ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

    ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\][%s]", register = { cr = false } },
    ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\][%s]", register = { cr = false } },
    ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\][%s]", register = { cr = false } },
  },
}

return {
  {
    "echasnovski/mini.pairs",
    version = "*",
    config = function()
      vim.api.nvim_create_autocmd("RecordingEnter", {
        callback = function()
          vim.b.minipairs_disable = true
        end,
      })
      vim.api.nvim_create_user_command("MiniPairEnable", function()
        vim.b.minipairs_disable = false
      end, {})
      vim.api.nvim_create_user_command("MiniPairDisable", function()
        vim.b.minipairs_disable = true
      end, {})
      vim.api.nvim_create_user_command("MiniPairToggle", function()
        vim.b.minipairs_disable = not vim.b.minipairs_disable
      end, {})
      require("mini.pairs").setup(opts)
    end,
  },
}
