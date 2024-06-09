local abbr = vim.cmd["iabbrev"]

abbr("<buffer>", "lc", "local")
abbr("<buffer>", "let", "local")

vim.opt_local.fo:remove("o")
