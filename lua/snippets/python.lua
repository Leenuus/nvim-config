local ls = require("luasnip")
local s = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snip1 = s(
  "main",
  fmt(
    [[def main():
    {}

if __name__ == '__main__':
    main()]],
    {
      insert(1, "pass"),
    }
  )
)

local python_snips = {
  snip1,
}

return python_snips