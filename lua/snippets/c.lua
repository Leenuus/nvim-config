local ls = require("luasnip")
local s = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snip1 = s(
  "main",
  fmt(
    [[#include <stdio.h>

int main(){{
  {}
  return 0;
}}]],
    {
      insert(1),
    }
  )
)

local snips = { snip1 }

return snips
