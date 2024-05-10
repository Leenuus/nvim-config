local ftplugin = vim.api.nvim_create_augroup("filetype-config", {
  clear = true,
})

-- NOTE: close man page easily
-- steal from lazyvim
vim.api.nvim_create_autocmd("FileType", {
  group = ftplugin,
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- NOTE: quit some buf with `q`
-- steal from lazyvim
vim.api.nvim_create_autocmd("FileType", {
  group = ftplugin,
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

vim.api.nvim_create_autocmd("FileType", {
  group = ftplugin,
  pattern = { "c" },
  callback = function(event)
    vim.bo[event.buf].shiftwidth = 4
    vim.bo[event.buf].tabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = ftplugin,
  pattern = { "fish" },
  callback = function(event)
    vim.bo[event.buf].shiftwidth = 2
    vim.bo[event.buf].tabstop = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = ftplugin,
  pattern = { "renpy" },
  callback = function(event)
    local win = vim.api.nvim_get_current_win()
    vim.wo[win].foldmethod = "indent"
  end,
})


vim.api.nvim_create_autocmd("FileType", {
  group = ftplugin,
  pattern = { "python" },
  callback = function(event)
    vim.bo[event.buf].shiftwidth = 4
    vim.bo[event.buf].tabstop = 4
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   group = ftplugin,
--   pattern = { "asm" },
--   callback = function(event)
--     vim.bo[event.buf].commentstring = ";; "
--   end,
-- })
