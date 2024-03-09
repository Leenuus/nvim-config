-- local function route_skip(find)
--   return {
--     filter = {
--       event = "msg_show",
--       kind = "",
--       find = find,
--     },
--     opts = { skip = true },
--   }
-- end

local function route_mini(filter)
  return {
    filter = filter,
    view = "mini",
  }
end

local routes = {
  route_mini({
    event = "msg_show",
    kind = "",
    find = "written",
  }),
  route_mini({
    event = "msg_show",
    kind = "",
    find = "more lines",
  }),
  route_mini({
    event = "msg_show",
    kind = "",
    find = "fewer lines",
  }),
  route_mini({
    min_width = vim.api.nvim_win_get_width(0) / 4,
  }),
  route_mini({
    min_height = vim.api.nvim_win_get_height(0) / 4,
  }),
  route_mini({
    max_height = vim.api.nvim_win_get_height(0) / 4,
  }),
  route_mini({
    max_width = vim.api.nvim_win_get_height(0) / 4,
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
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      routes = routes,
    })
  end,
}
