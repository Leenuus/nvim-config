vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {})

vim.cmd([[colorscheme tokyonight]])

require("options")
require("keybindings")
require("highlight")
require("tree-sitter")
require("telescope-settings")
require("lsp")
require("cursor")
require("recording")
require("snippets")
require("filetype")

-- vim: ts=2 sts=2 sw=2 et
