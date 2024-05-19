-- EXPORT
local cursor_setting = vim.api.nvim_create_augroup("cursor_setting", { clear = true })

-- EXPORT
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

local recording_gp = vim.api.nvim_create_augroup("recording-notifications", { clear = true })

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
  group = recording_gp,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  pattern = "*",
  callback = function()
    require("notify")("Stop Recording", level, noption)
  end,
  group = recording_gp,
})

-- EXPORT
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
-- EXPORT
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- EXPORT
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("SpellCheck", { clear = true }),
  pattern = { "gitcommit" },
  callback = function()
    vim.wo.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("FormatOptions", { clear = true }),
  pattern = { "*" },
  callback = function()
    vim.opt_local.fo:remove("o")
  end,
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
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("filetype-config", {
    clear = true,
  }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "man",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>x<cr>", { buffer = event.buf, silent = true })
    vim.keymap.set("n", "<leader>q", "<cmd>x<cr>", { buffer = event.buf, silent = true })
  end,
})

-- abbr
vim.cmd([[Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}]])
vim.cmd([[Abolish teh{n,} the{n,}]])
vim.cmd([[Abolish cahr char]])
vim.cmd([[Abolish bsaic basic]])
vim.cmd([[Abolish suage usage]])
vim.cmd([[Abolish functoin function]])
vim.cmd([[Abolish lcoal local]])
vim.cmd([[Abolish scrpit script]])
vim.cmd([[Abolish scritp script]])
vim.cmd([[Abolish fasle false]])
vim.cmd([[Abolish optoin option]])
vim.cmd([[Abolish amp map]])
vim.cmd([[Abolish edn end]])
vim.cmd([[Abolish retunr return]])
vim.cmd([[Abolish retrun return]])
vim.cmd([[Abolish possbile possible]])
vim.cmd([[Abolish resouce{,s} resource{,s}]])
vim.cmd([[Abolish waht what]])

local extension = {
  todo = "markdown",
  sshconfig = "sshconfig",
}

-- NOTE: never work, seem bugs
local pattern = {}

local filename = {
  ["urls"] = "rssfeed",
  [".fishrc"] = "fish",
}

vim.filetype.add({
  extension = extension,
  pattern = pattern,
  filename = filename,
})

-- EXPORT
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("filetype-detection", { clear = true }),
  pattern = {
    "bash-fc*",
  },
  callback = function()
    vim.bo.filetype = "bash"
  end,
})

-- themes
local themes = {
  "tokyonight-moon",
  "tokyonight-storm",
  "tokyonight-night",
  "tokyonight",
  "ayu-mirage",
  -- "ayu-dark",
}
local theme = themes[math.random(#themes)]
theme = "ayu-mirage"
local ok, _ = pcall(vim.cmd["colorscheme"], theme)
if not ok then
  vim.cmd("colorscheme default")
end
