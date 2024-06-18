local vertical_spliter = function(right)
  return function(opts)
    local cmd = opts.args
    local old1 = vim.o.splitright
    vim.o.splitright = right
    vim.cmd("vertical " .. cmd)
    vim.o.splitright = old1
  end
end

local horizontal_spliter = function(below)
  return function(opts)
    local cmd = opts.args
    local old = vim.o.splitbelow
    vim.o.splitbelow = below
    vim.cmd("horizontal " .. cmd)
    vim.o.splitbelow = old
  end
end

vim.api.nvim_create_user_command("SplitLeft", vertical_spliter(false), { nargs = 1 })
vim.api.nvim_create_user_command("SplitRight", vertical_spliter(true), { nargs = 1 })
vim.api.nvim_create_user_command("SplitAbove", horizontal_spliter(false), { nargs = 1 })
vim.api.nvim_create_user_command("SplitBelow", horizontal_spliter(true), { nargs = 1 })
