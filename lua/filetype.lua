local augroup = require("helpers").augroup
local gp = augroup("filetype-detection")

local extension = {
  todo = "markdown",
  sshconfig = "sshconfig",
}

-- NOTE: never work, seem bugs
local pattern = {}

local filename = {
  ["urls"] = "rssfeed",
}

vim.filetype.add({
  extension = extension,
  pattern = pattern,
  filename = filename,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = gp,
  pattern = {
    "bash-fc*",
  },
  callback = function()
    vim.bo.filetype = "bash"
  end,
})
