local tmap = require("helpers").map_toggle
return {
  {
    "mcchrish/nnn.vim",
    config = function()
      require("nnn").setup({
        -- NOTE: -o used to open file only on pressing <Enter>
        -- -c used to open 8-color
        -- experience is much more better now with nnn integration
        -- TODO: going to use nnn as explorer when we open directory with
        -- neovim
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
      tmap("e", "<cmd>NnnPicker %:p:h<CR>", "[E]xplorer")
    end,
  },
}
