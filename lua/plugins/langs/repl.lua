return {
  {
    "Vigemus/iron.nvim",
    config = function()
      local iron = require("iron.core")
      local view = require("iron.view")

      local opts = {
        config = {
          scratch_repl = true,
          repl_definition = {
            sh = {
              command = { "bash" },
            },
            python = {
              command = { "python" },
            },
          },
          repl_open_cmd = view.split.vertical.topleft("40%"),
        },
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true,
      }
      iron.setup(opts)

      vim.keymap.set("n", "<leader>es", "<cmd>IronRepl<cr>")
      vim.keymap.set("n", "<leader>er", "<cmd>IronRestart<cr>")

      -- vim.keymap.set("n", "<leader>ee", function()
      --   iron.send_motion("af")
      -- end, { desc = "send current function" })
      vim.keymap.set("n", "<leader>el", iron.send_line)
      vim.keymap.set("n", "<leader>ee", iron.send_file)
      vim.keymap.set("x", "<leader>e", iron.visual_send)
      vim.keymap.set("x", "<leader>m", iron.mark_visual)
      vim.keymap.set("x", "<leader>em", iron.send_mark)
    end,
  },
}
