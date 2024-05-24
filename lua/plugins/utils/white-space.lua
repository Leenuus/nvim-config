return {
  "echasnovski/mini.trailspace",
  version = "*",
  config = function()
    vim.defer_fn(require("mini.trailspace").setup, 0)
    vim.api.nvim_create_user_command("MiniTrimWhiteSpace", function()
      pcall(MiniTrailspace.trim)
    end, {})
  end,
}
