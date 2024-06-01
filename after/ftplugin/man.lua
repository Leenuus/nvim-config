vim.opt_local.number = true
vim.opt_local.scrolloff = math.floor(vim.api.nvim_win_get_height(0) / 2)

local pat = "^\\w"
vim.keymap.set("n", "<leader>jj", function()
  vim.fn.search(pat)
end, { desc = "go to next section" })

vim.keymap.set("n", "<leader>kk", function()
  vim.fn.search(pat, "b")
end, { desc = "go to next section" })

vim.keymap.set("n", "mm", "<cmd>ManSetMark<cr>", { desc = "set man page mark" })
vim.keymap.set("n", "<leader><space>", "<cmd>ManGetMarks<cr>", { desc = "go to man page mark" })
