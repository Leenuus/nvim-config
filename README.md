## TODO

- a keybinding to jump to the corresponding snippets file
- a treesitter program to remove trailing spaces, without compromising string literal
- More to read in `:help function-list`
- write a `im-select` alternative using simple shell script working with dbus
- learning mode for new keybindings, floating window on the right top or notification when pressing an old one

## NOTES

### List/Table Pitfalls

Common pitfalls I met this night:

- `vim.tbl_extend` not work for list-like table

- `vim.list_extend(dst, src, start, end)` change the dst and return it, this means:

this is dangerous to use this function to build multiple list sharing the same part, meaning that the later call of this func changes the value it returned before!!

make use of `vim.deepcopy` to avoid it:

```lua
local dst = { 1, 2 }
local tail_of_t1 = { 3, 4 }
local tail_of_t2 = { 5, 6 }
local tb1  = vim.list_extend(vim.deepcopy(dst), tail_of_t1)
local tb2  = vim.list_extend(vim.deepcopy(dst), tail_of_t2)
```

### Evaluation Timing and Currying

When dealing with file path relative keybindings, make sure expand/get the path as the keybinding function is invoked, making sure **these codes are not evaluated at neovim startup**. So you may need a closure for most of the times.
