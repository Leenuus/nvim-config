vim.keymap.set("n", "<leader>Q", 'vgg/^#<CR><UP>d<CMD>call histdel("search", -1) | noh<CR><CMD>x<CR>', { buffer = 0, silent = true, desc = "Abort Commit" })
