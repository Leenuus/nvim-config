local ls = require("luasnip")
local s = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local mut_ref = s("sm", fmt("&mut self", {}))
local immut_ref = s("sr", fmt("&self", {}))

local if_debug = s(
  "ifd",
  fmt(
    [[if cfg!(debug_assertions) {{
{}
}}]],
    { insert(0) }
  )
)

local snip4 = s("ift", fmt("#[cfg(test)]", {}))

local snips = { mut_ref, immut_ref, if_debug, snip4 }

return snips
