local nmap = require("helpers").map_normal

return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      local sources = {
        -- NOTE: completion
        null_ls.builtins.completion.spell,
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
        -- hover
        null_ls.builtins.hover.printenv,
      }
      null_ls.setup({
        sources = sources,
      })
      -- nmap('Q', vim.lsp.buf.format)
      nmap("Q", vim.lsp.buf.format)
    end,
  },
  -- {
  --   "stevearc/conform.nvim",
  --   enabled = false,
  --   config = function()
  --     require("conform").setup({
  --       formatters_by_ft = {
  --         lua = { "stylua" },
  --         awk = { "awk" },
  --         go = { "gofmt" },
  --         sh = { "shfmt" },
  --         bash = { "shfmt" },
  --         toml = { "taplo" },
  --         yaml = { "yamlfmt" },
  --         zig = { "zigfmt" },
  --         c = { "clang_format" },
  --         cpp = { "clang_format" },
  --         clojure = { "cljstyle" },
  --         fish = { "fish_indent" },
  --         markdown = { "markdownlint-cli2" },
  --         python = { "black" },
  --         -- TODO: add `ocaml` formatter setting
  --         -- ocaml = { "dune fmt" },
  --       },
  --     })
  --     vim.api.nvim_create_user_command("Format", function(args)
  --       local range = nil
  --       if args.count ~= -1 then
  --         local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
  --         range = {
  --           start = { args.line1, 0 },
  --           ["end"] = { args.line2, end_line:len() },
  --         }
  --       end
  --       require("conform").format({ async = true, lsp_fallback = true, range = range })
  --     end, { range = true })
  --     nmap("Q", function()
  --       vim.cmd([[Format]])
  --       local buf = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  --       for i, line in pairs(buf) do
  --         buf[i] = vim.fn.trim(line, " ", 2)
  --       end
  --       vim.api.nvim_buf_set_lines(0, 0, -1, false, buf)
  --     end)
  --     -- TODO: 7. format on save
  --   end,
  -- }
}
