local ls = require("luasnip")
local s = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local main = s(
  "main",
  fmt(
    [[#!/usr/bin/env python

def main():
    {}

if __name__ == '__main__':
    main()]],
    {
      insert(0, "pass"),
    }
  )
)

local python_snips = {
  main,
}

return python_snips
