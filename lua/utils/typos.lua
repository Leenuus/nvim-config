-- TODO: vim-abolish like {} to reduce size of typos file
-- NOTE: a typo fixer like vim-abolish

local default_source = vim.fn.stdpath("config") .. "/typos.txt"
local default_sep = " "
local capitalize = require("helpers").capitalize

local function abolish(wrong, right, buffer)
  local cmd = string.format("iabbrev %s %s %s", buffer and "<buffer>" or "", wrong, right)
  local cmd1 = string.format("iabbrev %s %s", capitalize(wrong), capitalize(right))
  vim.cmd(cmd)
  vim.cmd(cmd1)
end

local function parse_typo_file(typo_source, sep)
  local ft_abolish = {}

  ft_abolish["all"] = {}

  for line in io.lines(typo_source) do
    local l = vim.fn.split(line, sep)
    local wrong = l[1]
    local right = l[2]
    local ft = l[3]

    if ft ~= nil then
      if ft_abolish[ft] == nil then
        ft_abolish[ft] = {}
      end
      table.insert(ft_abolish[ft], { wrong, right })
    else
      table.insert(ft_abolish["all"], { wrong, right })
    end
  end

  return ft_abolish
end

local setup = function(typo_source, sep)
  if sep == nil then
    sep = default_sep
  end

  if typo_source == nil then
    typo_source = default_source
  end

  local typos = parse_typo_file(typo_source, sep)

  for _, v in ipairs(typos["all"]) do
    local wrong = v[1]
    local right = v[2]
    abolish(wrong, right)
  end

  local g = vim.api.nvim_create_augroup("FileTypeAbolish", { clear = true })

  for ft, _ in pairs(typos) do
    if ft == "all" then
      goto continue
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = ft,
      callback = function()
        for _, v in ipairs(typos[ft]) do
          local wrong = v[1]
          local right = v[2]
          abolish(wrong, right, true)
        end
      end,
      group = g,
    })
    ::continue::
  end
end

return {
  setup = setup,
  abolish = abolish,
}
