return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      local spell = null_ls.builtins.completion.spell.with({
        filetypes = { "markdown" },
      })
      local printenv = null_ls.builtins.hover.printenv.with({
        filetypes = { "bash", "sh", "fish", "dosbatch", "ps1" },
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
        null_ls.builtins.formatting.yamlfmt,
        null_ls.builtins.formatting.codespell, -- spell
        -- markdown
        null_ls.builtins.formatting.cbfmt, -- markdown code block
        -- hover
        printenv,
        -- dia
        null_ls.builtins.diagnostics.codespell,
        null_ls.builtins.diagnostics.fish,
      }
      null_ls.setup({
        sources = sources,
      })
    end,
  },
}
