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
    [[#!/usr/bin/env python

def main():
    {}

if __name__ == '__main__':
    main()]],
    {
      i(0, "pass"),
    }
  )
)

local dict = s(
  "de",
  fmt([[{}["{}"] = {}]], {
    i(1, "dictionary"),
    rep(2),
    i(2, "entry"),
  })
)

local home = s("home", {
  t({ "from os import environ", 'HOME = environ["HOME"]' }),
})

local disable_diagnostics = s("diag", {
  t(" # type: ignore"),
})

local python_snips = {
  main,
  dict,
  home,
  disable_diagnostics,
}

return python_snips
