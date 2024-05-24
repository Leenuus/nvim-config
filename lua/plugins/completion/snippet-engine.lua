return {
  {
    "L3MON4D3/LuaSnip",
    build = (function()
      if vim.fn.has("win32") == 1 then
        return
      end
      return "make install_jsregexp"
    end)(),
  },
  -- { dir = "~/Projects/Neovims/friendly-snippets" },
}
