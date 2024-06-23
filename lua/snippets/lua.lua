local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local sn = ls.snippet_node

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

local smart_require = s(
  "re",
  fmt(
    [[local {} = require('{}')
{}]],
    {
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

-- TODO: update to choice node for more or fewer snippets expansion
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

local snippets = s(
  "snip",
  fmta(
    string.format(
      [[local <> = s(
  '<>',
  fmt(
    [[<>%s,
    {},
    {delimiters = '<>'}
  )
)
  ]],
      "]]"
    ),
    {
      i(1, "name"),
      i(2, "trig"),
      i(0),
      c(3, { t("<>"), t("{}") }),
    }
  )
)

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
    print(vim.inspect(choice))
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

local set_cmd_keymap = s(
  "kc",
  fmt([[vim.keymap.set(<>, '<>', <>, { desc = '<>', <> })]], {
    c(1, {
      t("'n'"),
      t("'x'"),
      t("'i'"),
      t("{ 'n', 'x' }"),
    }),
    c(2, {
      sn(nil, { t("<leader>"), i(1) }),
      i(1, ""),
    }),
    c(5, {
      sn(nil, { t("function() "), i(1), t("end") }),
      sn(nil, { t("'<CMD>"), i(1), t("<CR>'") }),
      sn(nil, { t("'<Plug>"), i(1), t("'") }),
      sn(nil, { t("'"), i(1), t("'") }),
    }),
    i(4, "desc"),
    c(3, {
      i(1, ""),
      t("remap = true"),
      t("buffer = 0"),
      t("buffer = 0, remap = true"),
    }),
  }, { delimiters = "<>" })
)

local ui_input = s(
  "input",
  fmt(
    [[vim.ui.input({ prompt = "<>", default = '<>' }, function(name)
  if name == '' or name == nil then
    <>
  end
end)]],
    {
      i(1),
      i(2),
      i(0),
    },
    { delimiters = "<>" }
  )
)

local p_call = s(
  "pc",
  fmt([[<>pcall(function() <> end)]], {
    c(1, {
      t(""),
      t("local ok, _ = "),
      t("local ok, res = "),
    }),
    i(2),
  }, { delimiters = "<>" })
)

local pretty_print = s("pp", fmt([[print(vim.inspect(<>))]], { i(1) }, { delimiters = "<>" }))

local tenary = s(
  "?",
  c(1, {
    fmt([[<> and <> or <>]], { i(1, "cond"), i(2, "true"), i(0, "false") }, { delimiters = "<>" }),
    fmt([[<> and <>]], { i(1, "cond"), i(2, "true") }, { delimiters = "<>" }),
    fmt([[<> or <>]], { i(1, "cond"), i(2, "false") }, { delimiters = "<>" }),
  })
)

local lua_snips = {
  main,
  smart_require,
  check_type,
  deep_extend,
  snippets,
  ui_select,
  if_nil,
  if_not_nil,
  disable_diagnositcs,
  set_cmd_keymap,
  pretty_print,
  ui_input,
  p_call,
  tenary,
}

return lua_snips
