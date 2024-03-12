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
}

return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
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
    nmap("sM", "<CMD>Noice telescope<CR>", { desc = "search for messages" })
  end,
}
