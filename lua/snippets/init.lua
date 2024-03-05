-- some luasnip snippets

local ls = require("luasnip")
local bash_snips = require('snippets.bash')
local python_snips = require('snippets.python')
local c_snips = require('snippets.c')
local fish_snips = require('snippets.fish')

ls.add_snippets("sh", bash_snips)
ls.add_snippets("bash", bash_snips)
ls.add_snippets("python", python_snips)
ls.add_snippets("c", c_snips)
ls.add_snippets("fish", fish_snips)