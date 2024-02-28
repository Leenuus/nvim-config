return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        awk = { "awk" },
        go = { "gofmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        toml = { "taplo" },
        yaml = { "yamlfmt" },
        zig = { "zigfmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        clojure = { "cljstyle" },
        fish = { "fish_indent" },
        markdown = { "markdownlint-cli2" },
        python = { "black" },
      },
    })
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })
    vim.keymap.set("n", "Q", "<cmd>Format<cr>")
  end,
}
