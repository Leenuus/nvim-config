local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local main = s(
  "main",
  fmt(
    [[
local M = {{}}

{}

return M
]],
    {
      i(0),
    }
  )
)

local pp = s(
  "pp",
  fmt(
    [[local function pp(arg)
  print(vim.inspect(arg))
end
  ]],
    {}
  )
)

local lua_snips = {
  main,
  pp,
}

return lua_snips
