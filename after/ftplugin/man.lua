vim.opt_local.number = true
vim.opt_local.scrolloff = math.floor(vim.api.nvim_win_get_height(0) / 2)

local pat = "^\\w"
vim.keymap.set("n", "<leader>jj", function()
  vim.fn.search(pat)
end, { desc = "go to next section" })

vim.keymap.set("n", "<leader>kk", function()
  vim.fn.search(pat, "b")
end, { desc = "go to next section" })

vim.keymap.set("n", "gd", "<C-]>", { desc = "set man page mark", buffer = 0 })
vim.keymap.set("n", "mm", "<cmd>ManSetMark<cr>", { desc = "set man page mark", buffer = 0 })
vim.keymap.set("n", "<leader><space>", "<cmd>ManMarks<cr>", { desc = "go to man page mark", buffer = 0 })

vim.keymap.set("n", "|", "/^\\s*", { desc = "search for man page section", buffer = 0 })
