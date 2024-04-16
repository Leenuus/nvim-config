-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'

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

vim.defer_fn(function()
  require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = ensure_installed,

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = {},
    -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
    modules = {},
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-c>",
        node_incremental = "<c-d>",
        -- scope_incremental = '<c-c>',
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
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
        enable = false,
        set_jumps = true, -- whether to set jumps in the jumplist
        -- goto_next_start = {
        --   [']m'] = '@function.outer',
        --   [']]'] = '@class.outer',
        -- },
        -- goto_next_end = {
        --   [']M'] = '@function.outer',
        --   [']['] = '@class.outer',
        -- },
        -- goto_previous_start = {
        --   ['[m'] = '@function.outer',
        --   ['[['] = '@class.outer',
        -- },
        -- goto_previous_end = {
        --   ['[M'] = '@function.outer',
        --   ['[]'] = '@class.outer',
        -- },
      },
      swap = {
        enable = false,
        -- swap_next = {
        --   ['<leader>a'] = '@parameter.inner',
        -- },
        -- swap_previous = {
        --   ['<leader>A'] = '@parameter.inner',
        -- },
      },
    },
  })
end, 0)
