local nmap = require("helpers").map_normal

return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      local spell = null_ls.builtins.completion.spell.with({
        filetypes = { "markdown" },
      })

      local sources = {
        -- NOTE: completion
        spell,
        -- NOTE: formatter
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.cmake_format,
        null_ls.builtins.formatting.fish_indent,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.ocamlformat,
        null_ls.builtins.formatting.yamlfmt,
        null_ls.builtins.formatting.cbfmt,
        -- null_ls.builtins.formatting.textlint,
        -- hover
        null_ls.builtins.hover.printenv,
        -- dia
        null_ls.builtins.diagnostics.markdownlint_cli2,
      }
      null_ls.setup({
        sources = sources,
      })
    end,
  },
}
