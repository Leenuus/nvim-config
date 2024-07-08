local abbr = vim.cmd["iabbrev"]

abbr("<buffer>", "lc", "local")
abbr("<buffer>", "let", "local")

vim.opt_local.formatoptions:remove("o")

-- NOTE: simple luapad alternative
vim.keymap.set("n", "<leader>ee", "<CMD>Redir %lua<CR>", { desc = "Vim eval current buffer", buffer = 0 })
vim.keymap.set("n", "<leader>el", "<CMD>Redir .lua<CR>", { desc = "Vim eval current buffer", buffer = 0 })
