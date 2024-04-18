local augroup = require("helpers").augroup
local cursor_setting = augroup("cursor_setting")

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  pattern = "*",
  callback = function()
    vim.cmd([[
    set cursorline
    set cursorcolumn
    silent !echo -ne "\e[2 q"
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
    ]])
  end,
  group = cursor_setting,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
  pattern = "*",
  callback = function()
    vim.cmd([[
    set guicursor=a:ver90"
    ]])
  end,
  group = cursor_setting,
})

-- NOTE: close man page easily
-- steal from lazyvim
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- NOTE: quit some buf with `q`
-- steal from lazyvim
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    vim.keymap.set("n", "<leader>q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- NOTE: check whether a reload is needed
-- steal from lazyvim
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

local gp = vim.api.nvim_create_augroup("recording-notifications", { clear = true })

local noption = {
  title = "Recording",
  timeout = 1,
  hide_from_history = true,
  icon = "",
}
local level = vim.log.levels.INFO

vim.api.nvim_create_autocmd("RecordingEnter", {
  pattern = "*",
  callback = function()
    require("notify")("Start Recording", level, noption)
  end,
  group = gp,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  pattern = "*",
  callback = function()
    require("notify")("Stop Recording", level, noption)
  end,
  group = gp,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- abbr
vim.cmd([[Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}]])
vim.cmd([[Abolish teh the]])
vim.cmd([[Abolish cahr char]])
vim.cmd([[Abolish bsaic basic]])
vim.cmd([[Abolish suage usage]])
vim.cmd([[Abolish functoin function]])
