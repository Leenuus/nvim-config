local helpers = require("helpers")
helpers.toggle_scrolloff()

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

-- split right
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.virtualedit = "block"
-- vim.o.inccommand = "split"

vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.updatetime = 100 -- faster completion (4000ms default)
vim.opt.undofile = true -- enable persistent undo
vim.opt.list = true
vim.opt.listchars='tab:>-,lead:.'

-- @diagnostic disable-next-line: undefined-field
if vim.g.neovide then -- ignore
  -- neovim gui neovide
  vim.g.neovide_window_blurred = true
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_show_border = true
  vim.g.neovide_transparency = 0.6
  vim.g.neovide_theme = "auto"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5

  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
  end)
end
