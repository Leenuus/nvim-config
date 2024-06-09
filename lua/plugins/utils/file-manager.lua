local function nop() end

local function make_executable()
  local ctx = require("lir").get_context()
  local file = ctx:current()
  file = file.fullpath
  local perm = vim.fn.getfperm(file)
  perm = perm:sub(1, 2) .. "x" .. perm:sub(4)
  vim.fn.setfperm(file, perm)
end

return {
  {
    "tamago324/lir.nvim",
    config = function()
      local actions = require("lir.actions")

      require("lir").setup({
        show_hidden_files = true,
        ignore = {},
        devicons = {
          enable = true,
          highlight_dirname = false,
        },
        mappings = {
          ["l"] = actions.edit,
          ["<cr>"] = actions.edit,
          ["<C-s>"] = actions.split,
          ["<C-p>"] = actions.vsplit,
          ["<C-t>"] = actions.tabedit,

          ["h"] = actions.up,
          ["q"] = actions.quit,

          ["d"] = actions.mkdir,
          ["n"] = actions.newfile,
          ["r"] = actions.rename,
          ["@"] = actions.cd,
          ["y"] = actions.yank_path,
          ["."] = actions.toggle_show_hidden,
          ["x"] = actions.delete,
          ["8"] = make_executable,
          ["*"] = make_executable,
          ["J"] = nop,
          ["C"] = nop,
          ["X"] = nop,
          ["P"] = nop,
        },
        float = {
          winblend = 0,
          curdir_window = {
            enable = false,
            highlight_dirname = false,
          },
          win_opts = function()
            local width = math.floor(vim.o.columns * 0.8)
            local height = math.floor(vim.o.lines * 0.7)
            return {
              width = width,
              height = height,
              relative = "win",
            }
          end,
        },
        hide_cursor = true,
      })

      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "lir" },
        callback = function() end,
      })
      vim.api.nvim_create_user_command("LirToggleCwd", function()
        require("lir.float").toggle()
      end, {})
      vim.keymap.set("n", "<leader>te", "<CMD>LirToggleCwd<CR>", { desc = "Open File Manager" })
    end,
  },
}
