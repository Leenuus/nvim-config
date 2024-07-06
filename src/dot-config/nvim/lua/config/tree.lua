local ensure_installed = {
  "c",
  "cpp",
  "go",
  "rust",
  "nasm",
  "sql",
  "zig",
  -- scripts
  "javascript",
  "typescript",
  "lua",
  "python",
  "vimdoc",
  "vim",
  "bash",
  "awk",
  "fish",
  "jq",
  -- lisp
  -- injections
  "luap",
  "jsdoc",
  "luadoc",
  "regex",
  "markdown_inline",
  -- data files
  "json",
  "jsonc",
  "yaml",
  "xml",
  -- web
  "html",
  "css",
  -- markups
  "markdown",
  -- docker
  "dockerfile",
  -- misc
  "tmux",
  "gitignore",
  "git_config",
  "git_rebase",
  "gitcommit",
  "gitattributes",
  "comment",
  "diff",
  "make",
}

vim.defer_fn(function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = ensure_installed,
    auto_install = false,
    sync_install = false,
    ignore_install = {},
    modules = {},
    highlight = {
      disable = function()
        return true
      end,
      enable = true,
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-c>",
        node_incremental = "<c-d>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["if"] = "@function.inner",
          ["af"] = "@function.outer",
          ["ia"] = "@parameter.inner",
          ["aa"] = "@parameter.outer",
          ["ic"] = "@conditional.inner",
          ["ac"] = "@conditional.outer",
        },
      },
      move = {
        enable = false,
      },
      swap = {
        enable = false,
      },
    },
    refactor = {
      highlight_definitions = {
        enable = true,
        clear_on_cursor_move = true,
      },
      highlight_current_scope = { enable = true },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = false,
        },
      },
    },
  })
end, 0)
