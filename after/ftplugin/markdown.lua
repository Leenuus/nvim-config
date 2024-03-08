local nmap = require("helpers").map_normal

local function titleCase(first, rest)
  return first:upper() .. rest:lower()
end

local function capitalize(str)
  return string.gsub(str, "(%a)([%w_']*)", titleCase)
end

nmap("Q", function()
  -- NOTE: capitalize headings
  vim.cmd([[Format]])
  local buf = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  for i, line in pairs(buf) do
    if string.match(line, "^#+") ~= nil then
      buf[i] = capitalize(line)
    end
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, true, buf)
end)