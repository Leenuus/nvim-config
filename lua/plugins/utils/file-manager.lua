local opts = {
  content = {
    -- Predicate for which file system entries to show
    filter = nil,
    -- What prefix to show to the left of file system entry
    prefix = nil,
    -- In which order to show file system entries
    sort = nil,
  },

  mappings = {
    close = "<ESC>",
    go_in = "l",
    go_in_plus = "L",
    go_out = "h",
    go_out_plus = "H",
    reset = "<BS>",
    reveal_cwd = "@",
    show_help = "g?",
    synchronize = "<leader>w",
    trim_left = "<",
    trim_right = ">",
  },

  -- General options
  options = {
    -- Whether to delete permanently or move into module-specific trash
    permanent_delete = true,
    -- Whether to use for editing directories
    use_as_default_explorer = true,
  },

  -- Customization of explorer windows
  windows = {
    -- Maximum number of windows to show side by side
    max_number = math.huge,
    -- Whether to show preview of file/directory under cursor
    preview = false,
    -- Width of focused window
    width_focus = 50,
    -- Width of non-focused window
    width_nofocus = 15,
    -- Width of preview window
    width_preview = 25,
  },
}

return {
  {
    {
      -- "echasnovski/mini.files",
      dir = "~/Projects/Neovims/mini.files",
      version = "*",
      config = function()
        require("mini.files").setup(opts)

        vim.api.nvim_create_user_command("MiniFiles", function(args)
          local p = args.args
          if p == nil then
            p = vim.api.nvim_buf_get_name(0)
          end

          local ok, _ = pcall(MiniFiles.open, p)
          if not ok then
            vim.notify("Not a valid path")
          end
        end, { nargs = "?", complete = "file" })
      end,
    },
  },
}
