local function make_executable()
  local ctx = require("lir").get_context()
  local file = ctx:current()
  file = file.fullpath
  local perm = vim.fn.getfperm(file)
  perm = perm:sub(1, 2) .. "x" .. perm:sub(4)
  vim.fn.setfperm(file, perm)
end

-- TODO:
-- try open window at cursor position
return {
  {
    {
      "echasnovski/mini.files",
      version = "*",
      opts = {
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
          synchronize = "=",
          trim_left = "<",
          trim_right = ">",
        },

        -- General options
        options = {
          -- Whether to delete permanently or move into module-specific trash
          permanent_delete = true,
          -- Whether to use for editing directories
          use_as_default_explorer = false,
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
      },
    },
  },
}
