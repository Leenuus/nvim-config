local function filesize()
  local size = vim.fn.getfsize(vim.fn.expand("%"))
  if size == -1 then
    return ""
  elseif size >= 1000 then
    return size / 1000 .. "KB"
  else
    return size .. "B"
  end
end

local function wordir()
  local dir = vim.fn.getcwd()
  local home = vim.env["HOME"]
  dir = string.gsub(dir, home, "~")
  dir = string.gsub(dir, '~/Projects/', "")
  return dir
end

return {
  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    -- See `:help lualine.txt`
    enabled = true,
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "branch" },
          lualine_b = { wordir },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { filesize },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })
    end,
  },
}
