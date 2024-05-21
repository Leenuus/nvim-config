-- some luasnip snippets

local add_snippets = require("luasnip").add_snippets
local bash_snips = require("snippets.bash")
local python_snips = require("snippets.python")
local c_snips = require("snippets.c")
local fish_snips = require("snippets.fish")
local rust_snips = require("snippets.rust")
local lua_snips = require("snippets.lua")
local markdown = require("snippets.markdown")

add_snippets("sh", bash_snips)
add_snippets("bash", bash_snips)
add_snippets("python", python_snips)
add_snippets("c", c_snips)
add_snippets("fish", fish_snips)
add_snippets("rust", rust_snips)
add_snippets("lua", lua_snips)
add_snippets("markdown", markdown)

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node
local t = ls.text_node

add_snippets("all", {
  s(
    "jk",
    fmt("{}{}", {
      c(1, {
        t("NOTE: "),
        t("TODO: "),
        t("FIXME: "),
      }),
      i(0),
    })
  ),
})

add_snippets("editorconfig", {
  s(
    "m",
    t([[
# EditorConfig is awesome: https://EditorConfig.org

# top-most EditorConfig file
root = true

# Unix-style newlines with a newline ending every file
[*]
end_of_line = lf
insert_final_newline = false
charset = utf-8
indent_style = space
indent_size = 2

[Makefile]
indent_style = tab
indent_size = 1

[*.py]
indent_style = space
indent_size = 4
]])
  ),
})
