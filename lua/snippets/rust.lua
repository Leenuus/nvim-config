local ls = require("luasnip")
local s = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snip1 = s("sm", fmt("&mut self", {}))
local snip2 = s("sr", fmt("&self", {}))

local snip3 = s(
  "ifd",
  fmt(
    [[if cfg!(debug_assertions) {{
{}
}}]],
    { insert(0) }
  )
)

local snip4 = s("ift", fmt("#[cfg(test)]", {}))

local snips = { snip1, snip2, snip3, snip4 }

return snips
