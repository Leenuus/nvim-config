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

-- TODO: udpate to choice node for more or fewer snippets expansion
local check_type = s(
  "ty",
  fmt(
    [[if type({}) == 'string' then
    {}
elseif type({}) == 'table' then
    {}
end]],
    { i(1, "var"), i(2, "command"), rep(1), i(3, "command") }
  )
)

local deep_extend = s(
  "ex",
  fmt([[vim.list_extend(vim.deepcopy({}), {})]], {
    i(1, "dst"),
    i(2, "src"),
  })
)

-- TODO: dynamic node to detect whether fmt and s are imported
local snippets = s(
  "snip",
  fmt(
    string.format(
      [[local <> = s('<>',
  fmt([[<>%s,
  {

  },
  {delimiters = '<<>>'}))]],
      "]]"
    ),
    {
      i(1, "name"),
      i(2, "trigger"),
      i(0, "snip"),
    },
    {
      delimiters = "<>",
    }
  )
)

-- todo select tempaltes
local ui_select = s(
  "se",
  fmt(
    [[vim.ui.select(<>,{
    prompt = "<>",
    format_item = function(item)
      <>
      return item
    end,
  }, function(choice)
    logger.info("choice: ", choice)
    if choice then
      <>
    end
  end)

  ]],
    {
      i(1, "items"),
      i(2, "prompt"),
      i(3, "-- format item"),
      i(4, "callback"),
    },
    { delimiters = "<>" }
  )
)

local if_nil = s(
  "ifn",
  fmt(
    [[if <> == nil then
  <> = <>
end]],
    {
      i(1, "var"),
      rep(1),
      i(2, "default"),
    },
    { delimiters = "<>" }
  )
)

local if_not_nil = s(
  "ifnn",
  fmt(
    [[if <> ~= nil then
  <>
end]],
    {
      i(1, "var"),
      i(0, "command"),
    },
    { delimiters = "<>" }
  )
)

local disable_diagnositcs = s("diag", {
  t("-- @diagnostic disable-next-line: "),
  i(0, "type"),
})

local lua_snips = {
  main,
  smart_require,
  logger,
  check_type,
  deep_extend,
  snippets,
  ui_select,
  if_nil,
  if_not_nil,
  disable_diagnositcs,
}

return lua_snips
