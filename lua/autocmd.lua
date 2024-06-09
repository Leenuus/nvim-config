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
    vim.opt_local.formatoptions:remove("o")
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

-- EXPORT
vim.api.nvim_create_autocmd({ "WinEnter", "WinResized" }, {
  pattern = "*",
  callback = function()
    local height = vim.api.nvim_win_get_height(0)
    vim.wo.scrolloff = math.floor(height / 2.5)
  end,
})

-- EXPORT
vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    vim.notify("Recording", vim.log.levels.INFO)
  end,
})

-- EXPORT
vim.api.nvim_create_autocmd("RecordingLeave", {
  pattern = "*",
  callback = function()
    vim.notify("Stop Recording", vim.log.levels.INFO)
  end,
})
