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
          ["aC"] = "@class.outer",
          ["iC"] = "@class.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["ii"] = "@conditional.inner",
          ["ai"] = "@conditional.outer",
          ["q"] = { query = "@string.inner", desc = "outer part of string" },
          ["Q"] = { query = "@string.outer", desc = "inner part of string" },
          ["ha"] = "@assignment.lhs",
          ["la"] = "@assignment.rhs",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = false,
        goto_next_start = {
          ["<leader>jf"] = "@function.outer",
          ["<leader>jc"] = "@class.outer",
          ["<leader>jj"] = "@chunk",
          ["<leader>ja"] = "@parameter.inner",
        },
        goto_next_end = {
          ["<leader>Jf"] = "@function.outer",
          ["<leader>Jc"] = "@class.outer",
          ["<leader>Jj"] = "@chunk",
          ["<leader>Ja"] = "@parameter.inner",
        },
        goto_previous_start = {
          ["<leader>kf"] = "@function.outer",
          ["<leader>kc"] = "@class.outer",
          ["<leader>kk"] = "@chunk",
          ["<leader>ka"] = "@parameter.inner",
        },
        goto_previous_end = {
          ["<leader>Kf"] = "@function.outer",
          ["<leader>Kc"] = "@class.outer",
          ["<leader>Kk"] = "@chunk",
          ["<leader>Ka"] = "@parameter.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>Sj"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>Sk"] = "@parameter.inner",
        },
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
