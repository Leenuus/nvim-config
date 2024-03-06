vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- require plugins from dir
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
require('filetype')

-- vim: ts=2 sts=2 sw=2 et
