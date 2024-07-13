local headers_path = vim.fn.stdpath("config") .. "/extra/dashboards/*.txt"

local headers = {}
for _, p in ipairs(vim.fn.split(vim.fn.glob(headers_path), "\n")) do
  local f = io.open(p)
  if f ~= nil then
    local c = vim.fn.split(f:read("*a"), "\n")
    table.insert(headers, c)
    f:close()
  end
end

local diary = {}
if vim.env["DIARY_TODAY"] then
  local dir = vim.fs.dirname(vim.env["DIARY_TODAY"])
  diary = {
    icon = "󱋡  ",
    desc = "Diary Today",
    key = "d",
    key_format = " %s",
    action = "cd " .. dir .. "| e $DIARY_TODAY",
  }
end

require("dashboard").setup({
  theme = "doom",
  config = {
    header = headers[math.random(#headers)],
    center = {
      {
        icon = "  ",
        desc = "New File",
        key = "e",
        key_format = " %s",
        action = "enew",
      },
      {
        icon = "  ",
        desc = "Search Files",
        key = "f",
        key_format = " %s",
        action = "FindFiles",
      },
      {
        icon = "󱋡  ",
        desc = "Recent Files",
        key = "o",
        key_format = " %s",
        action = "Telescope oldfiles",
      },
      {
        icon = "  ",
        desc = "Config",
        key = "c",
        key_format = " %s",
        action = "cd" .. vim.fn.stdpath("config") .. "| FindFiles",
      },
      {
        icon = "  ",
        desc = "Projects",
        key = "p",
        key_format = " %s",
        action = "FindProjects",
      },
      diary,
      {
        icon = "  ",
        desc = "Quit Neovim",
        key = "q",
        key_format = " %s",
        action = "quit",
      },
    },
    footer = {
      "Treasure Your Time!!!",
    },
  },
})

vim.api.nvim_create_autocmd("Filetype", {
  pattern = "dashboard",
  callback = function()
    vim.b.minitrailspace_disable = true
  end,
})
