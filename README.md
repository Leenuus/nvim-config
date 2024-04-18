## WIP

- More Telescope integration
- More Snippets
- More Treesitter

## TODO

- `nullls` custom source, `typos` is a good example to parse
- `noice` routes deep dive

## NOTES

Common pitfalls I met this night:

- `vim.tbl_extend` not work for list-like table

- `vim.list_extend(dst, src, start, end)` change the dst and return it, this means
this is dangerous to use this function to build mutiple list sharing the same part, meaning that the later call of this func changes the value it returned before!!

make use of `vim.deepcopy` to avoid it:

```lua
local dst = { 1, 2}
local tail_of_t1 = { 3, 4 }
local tail_of_t2 = { 5, 6 }
local tb1  = vim.list_extend(vim.deepcopy(dst), tail_of_t1))
local tb2  = vim.list_extend(vim.deepcopy(dst), tail_of_t2))
```

- when dealing with file path relative keybindings, make sure expand/get the path as the keybinding function is invoked, making sure **these codes are not evaluated at neovim startup**. So you may need a closure for most of the times.
