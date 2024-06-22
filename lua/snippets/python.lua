local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local main = s(
  "main",
  fmt(
    [[#!/usr/bin/env python


def main():
    {}


if __name__ == "__main__":
    main()]],
    {
      i(0, "pass"),
    }
  )
)

local home = s("home", {
  t({ "from os import environ", 'HOME = environ["HOME"]' }),
})

local disable_diagnostics = s("off", {
  c(1, {
    t("type: ignore"),
    t("fmt: off"),
  }),
})

local print = s(
  "ic",
  fmt(
    [[from icecream import ic
ic(<>)]],
    {
      i(0),
    },
    { delimiters = "<>" }
  )
)

local ift = s(
  "?",
  fmt([[<> if <> else <>]], {
    c(2, {
      i(1),
      rep(1),
    }),
    i(1, "True"),
    i(3, "False"),
  }, { delimiters = "<>" })
)

local is_instance = s(
  "isi",
  fmta(
    [[if isinstance(<>, <>):
    <>
]],
    {
      i(1),
      i(2, "str"),
      d(3, function(args)
        local var = args[1][1]
        local ty = args[2][1]
        if ty == "str" then
          return sn(nil, {
            t(var .. " = "),
            c(1, {
              t(var .. ".encode()"),
              t(("Path(%s)"):format(var)),
            }),
          })
        else
          return sn(nil, { i(1) })
        end
      end, { 1, 2 }),
    }
  )
)

local python_snips = {
  main,
  home,
  disable_diagnostics,
  print,
  ift,
  is_instance,
}

return python_snips
