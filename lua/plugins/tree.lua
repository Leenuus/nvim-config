local ensure_installed = {
  "c",
  "cpp",
  "go",
  "rust",
  -- scripts
  "javascript",
  "typescript",
  "lua",
  "python",
  "vimdoc",
  "vim",
  "bash",
  "fish",
  -- data files
  "json",
  "yaml",
  -- web
  "html",
  "css",
  -- markdown
  "markdown",
  "markdown_inline",
  -- docker
  "dockerfile",
  -- misc
  "gitignore",
}

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  "nvim-treesitter/nvim-treesitter-refactor",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      vim.defer_fn(function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = ensure_installed,
          auto_install = false,
          sync_install = false,
          ignore_install = {},
          modules = {},
          playground = {
            enable = true,
            updatetime = 25,
            persist_queries = false,
          },
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
              },
            },
            move = {
              enable = true,
              set_jumps = true,
              goto_next_start = {
                ["]f"] = "@function.outer",
                ["]c"] = "@class.outer",
              },
              goto_next_end = {},
              goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[c"] = "@class.outer",
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
    end,
  },
}
