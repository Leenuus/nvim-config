return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      {
        "tpope/vim-dadbod",
        lazy = true,
      },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_disable_progress_bar = 1
      vim.g.db_ui_disable_mappings = 1

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "dbui" },
        callback = function()
          vim.keymap.set("n", "<cr>", "<Plug>(DBUI_SelectLine)", { buffer = 0 })
          vim.keymap.set("n", "o", "<Plug>(DBUI_SelectLine)", { buffer = 0 })
          vim.keymap.set("n", "R", "<Plug>(DBUI_Redraw)", { buffer = 0 })
          vim.keymap.set("n", "d", "<Plug>(DBUI_DeleteLine)", { buffer = 0 })
          vim.keymap.set("n", "A", "<Plug>(DBUI_AddConnection)", { buffer = 0 })
          vim.keymap.set("n", "D", "<Plug>(DBUI_ToggleDetails)", { buffer = 0 })
          vim.keymap.set("n", "r", "<Plug>(DBUI_RenameLine)", { buffer = 0 })
          vim.keymap.set("n", "q", "<Plug>(DBUI_Quit)", { buffer = 0 })
          -- vim.keymap.set("n", "S", "<Plug>(DBUI_SelectLineVsplit)", { buffer = 0 })
          -- vim.keymap.set("n", "<c-k>", "<Plug>(DBUI_GotoFirstSibling)", { buffer = 0 })
          -- vim.keymap.set("n", "<c-j>", "<Plug>(DBUI_GotoLastSibling)", { buffer = 0 })
          -- vim.keymap.set("n", "<C-p>", "<Plug>(DBUI_GotoParentNode)", { buffer = 0 })
          -- vim.keymap.set("n", "<C-n>", "<Plug>(DBUI_GotoChildNode)", { buffer = 0 })
          -- vim.keymap.set("n", "K", "<Plug>(DBUI_GotoPrevSibling)", { buffer = 0 })
          -- vim.keymap.set("n", "J", "<Plug>(DBUI_GotoNextSibling)", { buffer = 0 })
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "dbout" },
        callback = function()
          vim.keymap.set("n", "<C-]>", "<Plug>(DBUI_JumpToForeignKey)", { buffer = 0 })
          vim.keymap.set("n", "vic", "<Plug>(DBUI_YankCellValue)", { buffer = 0 })
          vim.keymap.set("n", "yh", "<Plug>(DBUI_YankHeader)", { buffer = 0 })
          vim.keymap.set("n", "<Leader>R", "<Plug>(DBUI_ToggleResultLayout)", { buffer = 0 })
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql" },
        callback = function()
          vim.keymap.set("n", "<Leader>W", "<Plug>(DBUI_SaveQuery)", { buffer = 0 })
          vim.keymap.set({ "n", "x" }, "<Leader><Enter>", "<Plug>(DBUI_ExecuteQuery)", { buffer = 0 })
          -- vim.keymap.set("n", "<Leader>E", "<Plug>(DBUI_EditBindParameters)")
        end,
      })
    end,
  },
}
