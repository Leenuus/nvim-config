local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
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

local python_snips = {
  main,
  dict,
}

return python_snips
