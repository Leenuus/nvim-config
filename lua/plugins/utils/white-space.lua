return {
  "echasnovski/mini.trailspace",
  version = "*",
  event = "VeryLazy",
  config = function()
    vim.defer_fn(require("mini.trailspace").setup, 0)

    vim.api.nvim_create_user_command("TrimSpace", function()
      pcall(MiniTrailspace.trim)
    end, {})

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "dbout" },
      callback = function()
        vim.b["minitrailspace_disable"] = true
      end,
    })

    require("helpers").toggler("minitrailspace_disable", "MiniTrimSpace", false, true)
  end,
}
