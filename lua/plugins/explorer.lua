return {
  {
    "tamago324/lir.nvim",
    cmd = { "LirToggle", "LirOpen", "LirClose" },
    config = function()
      local actions = require("lir.actions")
      local mark_actions = require("lir.mark.actions")
      local clipboard_actions = require("lir.clipboard.actions")

      require("lir").setup({
        -- NOTE: not used, add it to make my lsp happy
        get_filters = function()
          return {}
        end,
        -- NOTE: deprecated, add it to make my lsp happy
        on_init = function() end,
        show_hidden_files = true,
        ignore = {
          "node_modules",
          ".git",
          "target",
          "build",
        },
        devicons = {
          enable = true,
          highlight_dirname = true,
        },
        mappings = {
          ["<cr>"] = actions.edit,
          ["l"] = actions.edit,
          ["<C-s>"] = actions.split,
          ["<C-p>"] = actions.vsplit,

          ["h"] = actions.up,
          ["q"] = actions.quit,
          ["<esc>"] = actions.quit,

          ["A"] = actions.mkdir,
          ["a"] = actions.newfile,
          ["r"] = actions.rename,
          ["@"] = actions.cd,
          ["y"] = actions.yank_path,
          ["."] = actions.toggle_show_hidden,
          ["d"] = actions.delete,
          ["x"] = actions.delete,

          ["m"] = function()
            mark_actions.toggle_mark("n")
            vim.cmd("normal! j")
          end,
          ["Y"] = clipboard_actions.copy,
          ["X"] = clipboard_actions.cut,
          ["P"] = clipboard_actions.paste,
        },
        float = {
          winblend = 0,
          curdir_window = {
            enable = false,
            highlight_dirname = true,
          },
          win_opts = function()
            local width = math.floor(vim.o.columns * 0.6)
            local height = math.floor(vim.o.lines * 0.5)
            return {
              border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
              width = width,
              height = height,
              row = math.floor((vim.o.lines - height) / 2),
              col = math.floor((vim.o.columns - width) / 2),
            }
          end,
        },
        hide_cursor = true,
      })
      -- NOTE: visual mode settings
      vim.api.nvim_create_autocmd({ "Filetype" }, {
        pattern = { "lir" },
        callback = function()
          -- use visual mode
          vim.api.nvim_buf_set_keymap(
            0,
            "x",
            "m",
            ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
            { noremap = true, silent = true }
          )
        end,
      })
      -- custom folder icon
      require("nvim-web-devicons").set_icon({
        lir_folder_icon = {
          icon = "",
          color = "#7ebae4",
          name = "LirFolderNode",
        },
      })

      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          if vim.bo.filetype == "lir" then
            vim.cmd([[
            ]])
          end
        end,
        pattern = "*",
      })
    end,
  },
}
