-- EXPORT
vim.g.mapleader = " "
-- EXPORT
vim.g.maplocalleader = "\\"

require("lazy-spec")
require("globals")
require("keybindings")
require("tele")
require("snippets")
require("autocmd")
require("lsp")
require("options")

-- vim: ts=2 sts=2 sw=2 et
