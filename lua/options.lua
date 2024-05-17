local helpers = require("helpers")
helpers.toggle_scrolloff()
-- EXPORT
vim.o.jumpoptions = "stack"
-- EXPORT
vim.o.relativenumber = true
-- EXPORT
vim.wo.number = true
-- EXPORT
vim.o.mouse = "a"
-- EXPORT
vim.o.clipboard = "unnamedplus"
-- EXPORT
vim.o.breakindent = true
-- EXPORT
vim.wo.signcolumn = "yes"
-- EXPORT
vim.o.completeopt = "menuone,noselect"
-- EXPORT
vim.o.hlsearch = true
-- EXPORT
vim.o.termguicolors = true

-- Case-insensitive searching UNLESS \C or capital in search
-- EXPORT
vim.o.ignorecase = true
-- EXPORT
vim.o.smartcase = true

-- Decrease update time
-- EXPORT
vim.o.updatetime = 250
-- EXPORT
vim.o.timeoutlen = 300

-- split right
-- EXPORT
vim.o.splitright = true
-- EXPORT
vim.o.splitbelow = true

-- EXPORT
vim.o.virtualedit = "block"
-- vim.o.inccommand = "split"

-- EXPORT
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
-- EXPORT
vim.opt.updatetime = 100 -- faster completion (4000ms default)
-- EXPORT
vim.opt.undofile = true -- enable persistent undo
-- EXPORT
vim.opt.list = true
-- EXPORT
vim.opt.listchars = "tab:>-,lead:."

-- session
-- EXPORT
vim.o.sessionoptions =
  "blank,buffers,curdir,folds,globals,help,localoptions,options,skiprtp,resize,tabpages,terminal,winpos,winsize"

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
