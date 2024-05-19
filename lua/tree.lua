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
      enable = true,
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
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
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ii"] = "@conditional.inner",
          ["ai"] = "@conditional.outer",
          ["q"] = { query = "@string.inner", desc = "outer part of string" },
          ["Q"] = { query = "@string.outer", desc = "inner part of string" },
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["<leader>jf"] = "@function.outer",
          ["<leader>jc"] = "@class.outer",
          ["<leader>jj"] = "@chunk",
        },
        goto_next_end = {},
        goto_previous_start = {
          ["<leader>kf"] = "@function.outer",
          ["<leader>kc"] = "@class.outer",
          ["<leader>kk"] = "@chunk",
        },
        goto_previous_end = {},
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
