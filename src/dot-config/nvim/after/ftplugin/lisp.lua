vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true
vim.b.minipairs_disable = true

vim.keymap.set({ "o", "x" }, "if", "<Plug>(sexp_inner_list)")
vim.keymap.set({ "o", "x" }, "af", "<Plug>(sexp_outer_list)")

vim.keymap.set("n", "<leader>ke", "<Plug>(sexp_move_to_prev_element_head)")
vim.keymap.set("n", "<leader>je", "<Plug>(sexp_move_to_next_element_head)")
