local tmap = require("helpers").map_toggle
local nmap = require("helpers").map_normal

local function route_mini(filter)
  return {
    filter = filter,
    view = "mini",
  }
end

local function route_discard(filter)
  return {
    filter = filter,
    opts = {
      skip = true,
    },
  }
end

local routes = {
  route_mini({
    event = "msg_show",
    kind = "",
    find = "written",
  }),
  route_discard({
    event = "msg_show",
    kind = "echo",
    find = "line",
  }),
  route_discard({
    event = "msg_show",
    kind = "",
    find = "line",
  }),
  route_discard({
    event = "msg_show",
    kind = "lua_error",
    find = "line",
  }),
  -- NOTE: remove annoying change related lua_error msg
  route_discard({
    event = "msg_show",
    kind = "lua_error",
    find = "change",
  }),
  -- NOTE: disable search related messages
  route_discard({
    event = "msg_show",
    kind = "emsg",
    find = "E486",
  }),
  route_discard({
    event = "msg_show",
    kind = "wmsg",
    find = "hit BOTTOM",
  }),
  {
    filter = {
      event = "msg_show",
      any = {
        { find = "%d+L, %d+B" },
        { find = "; after #%d+" },
        { find = "; before #%d+" },
      },
    },
    view = "mini",
  },
}

local opts = {
  timeout = 3000,
  max_height = function()
    return math.floor(vim.o.lines * 0.75)
  end,
  max_width = function()
    return math.floor(vim.o.columns * 0.3)
  end,
  on_open = function(win)
    vim.api.nvim_win_set_config(win, { zindex = 100 })
  end,
}

return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("notify").setup(opts)
    require("noice").setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- TODO: figure out what presets have done for us
      presets = {
        bottom_search = false,        -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
      routes = routes,
    })
    tmap("n", "<CMD>Noice debug<CR>", "debug noice")
    nmap("<leader>sM", "<CMD>Noice telescope<CR>", { desc = "search for messages" })
  end,
}
