-- [[ Setting options ]]
-- See `:help vim.o`

local helpers = require("helpers")
helpers.setup_scrolloff()

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.relativenumber = true
vim.wo.number = true
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.breakindent = true
vim.wo.signcolumn = "yes"
vim.o.completeopt = "menuone,noselect"
vim.o.hlsearch = true
vim.o.termguicolors = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300
