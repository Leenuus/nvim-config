-- EXPORT
vim.g.mapleader = " "
-- EXPORT
vim.g.maplocalleader = ","

require("lazy-spec")
require("options")
require("keybindings")
require("autocmd")
require('filetype')
require("lsp")
require("snippets")
require("utils")

-- vim: ts=2 sts=2 sw=2 et
