local abbr = vim.cmd["iabbrev"]

abbr("<buffer>", "lc", "local")
abbr("<buffer>", "let", "local")

vim.opt_local.formatoptions:remove("o")

-- NOTE: simple luapad alternative
vim.keymap.set('n', '<leader>ee', '<CMD>Redir %lua<CR>', { desc = 'Vim eval current buffer' } )
vim.keymap.set('n', '<leader>el', '<CMD>Redir .lua<CR>', { desc = 'Vim eval current buffer' } )

vim.cmd[[
ca  <buffer> pp Hey, do it in lua buffer! Use el/ee
]]
