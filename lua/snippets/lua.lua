local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
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

-- TODO: use treesitter to detact whether to insert the require part
local logger = s(
  "log",
  fmt(
    [[local logger = require('plenary.log')
logger.info({})
]],
    { i(1, "info") }
  )
)

local smart_require = s(
  "re",
  fmt(
    [[local {} = require('{}')
{}]],
    {
      -- TODO: detect trailing .<func>
      f(function(args, parent, user_args)
        local _ = parent
        local _ = user_args
        local module_name = args[1][1]
        local ms = vim.split(module_name, "%.", { trimempty = true })
        if ms ~= nil then
          -- NOTE: get the last component of module
          return ms[#ms]
        else
          return module_name
        end
      end, { 1 }),
      i(1, "module"),
      i(0),
    }
  )
)

local lua_snips = {
  main,
  pp,
  smart_require,
  logger,
}

return lua_snips
