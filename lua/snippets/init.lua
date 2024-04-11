-- some luasnip snippets

local add_snippets = require("luasnip").add_snippets
local bash_snips = require("snippets.bash")
local python_snips = require("snippets.python")
local c_snips = require("snippets.c")
local fish_snips = require("snippets.fish")
local rust_snips = require("snippets.rust")

add_snippets("sh", bash_snips)
add_snippets("bash", bash_snips)
add_snippets("python", python_snips)
add_snippets("c", c_snips)
add_snippets("fish", fish_snips)
add_snippets("rust", rust_snips)
