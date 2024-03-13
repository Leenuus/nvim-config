vim.api.nvim_create_autocmd({ "VimEnter" }, {
  pattern = "*",
  callback = function()
    vim.cmd([[
    colorscheme tokyonight
    "Noice debug
    silent !echo -ne "\e[2 q"
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
    set cursorline
    set cursorcolumn
    TransparentEnable
    ]])
  end,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
  pattern = "*",
  callback = function()
    vim.cmd([[
    set guicursor=a:ver90"
    ]])
  end,
})
