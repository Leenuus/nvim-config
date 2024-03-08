local tmap = require("helpers").map_toggle
return {
  {
    "mcchrish/nnn.vim",
    config = function()
      require("nnn").setup({
        -- NOTE: -o used to open file only on pressing <Enter>
        -- -c used to open 8-color
        -- experience is much more better now with nnn integration
        command = "nnn -C",
        set_default_mappings = 0,
        replace_netrw = 1,
        action = {
          -- ["<c-t>"] = "tab split",
          ["<c-s>"] = "split",
          ["<c-t>"] = "vsplit",
          -- ["<c-o>"] = copy_to_clipboard,
        },
      })
      -- DONE: use nnn as explorer when we open directory with neovim
      -- a vim script delete `.` buffer and close no name buffer
      -- and then we finally get to nnn explorer window
      vim.cmd([[
	augroup nnndirectory
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NnnExplorer' argv()[0] | wincmd p | bd | execute 'x' | endif
	augroup END
      ]])
      tmap("e", "<cmd>NnnPicker %:p:h<CR>", "[e]xplorer")
    end,
  },
}
