-- some luasnip snippets

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local bash_snip1 = s(
  "ty",
  fmt(
    [[if ! type {} >/dev/null 2>&1; then
  exit 1
fi
]],
    {
      insert(1, "program"),
    }
  )
)

local bash_snip2 = s(
  "parse",
  fmt(
    [[while [ "$#" -gt 0 ];do
  case "$1" in
    {} ) {};;
    *) ;;
  esac
  shift
done]],
    {
      insert(1, "match"),
      insert(2, "command"),
    }
  )
)

local bash_snip3 = s(
  "ifz",
  fmt(
    [[if [ -z "${}" ]; then
  {}
fi

{}]],
    {
      insert(1, "var"),
      insert(2, "command"),
      insert(3),
    }
  )
)

local bash_snip4 = s(
  "ifn",
  fmt(
    [[if [ -n "${}" ]; then
  {}
fi

{}]],
    {
      insert(1, "var"),
      insert(2, "command"),
      insert(3),
    }
  )
)

local bash_snips = { bash_snip1, bash_snip2, bash_snip3, bash_snip4 }

ls.add_snippets("sh", bash_snips)
ls.add_snippets("bash", bash_snips)