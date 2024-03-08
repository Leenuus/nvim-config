local tmap = require("helpers").map_toggle
return {
  {
    -- "mcchrish/nnn.vim",
    dir = "~/Projects/Neovims/nnn.vim",
    config = function()
      require("nnn").setup({
        -- DONE: use dedicated nnn executable with more vim friendly keymap
        command = "nvimnnn -C -A",
        set_default_mappings = 0,
        replace_netrw = 1,
        action = {
          ["<c-p>"] = "vsplit",
          ["<c-s>"] = "split",
          -- ["<c-t>"] = "tab split",
          -- ["<c-o>"] = copy_to_clipboard,
        },
      })
      -- DONE: use nnn as explorer when we open directory with neovim
      -- a vim script delete `.` buffer and close no name buffer
      -- and then we finally get to nnn explorer window
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

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
