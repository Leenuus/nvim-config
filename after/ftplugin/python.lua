vim.bo.shiftwidth = 4
vim.bo.tabstop = 4

local abbr = vim.cmd["iabbrev"]

abbr("<buffer>", "true", "True")
abbr("<buffer>", "false", "False")
