-- EXPORT
local cursor_setting = vim.api.nvim_create_augroup("cursor_setting", { clear = true })

-- EXPORT
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  pattern = "*",
  callback = function()
    vim.cmd('set guicursor=a:ver90"')
  end,
  group = cursor_setting,
})

-- EXPORT
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = vim.api.nvim_create_augroup("checktime", { clear = true }),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- EXPORT
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
})

-- NOTE: clear jumplist when entering so
-- no weird things happen when accidentally
-- press ctrl-o
-- EXPORT
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  pattern = "*",
  callback = function()
    vim.cmd("clearjumps")
  end,
  group = vim.api.nvim_create_augroup("jumps", { clear = true }),
})


-- EXPORT
vim.api.nvim_create_autocmd({ "WinEnter", "WinResized" }, {
  callback = function()
    local height = vim.api.nvim_win_get_height(0)
    vim.wo.scrolloff = math.floor(height / 2.5)
  end,
})
