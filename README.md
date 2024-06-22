# Neovim

## HACK

- [ ] project manager based on telescope
- [ ] write a `im-select` alternative using simple shell script working with dbus, make non-english input work in neovim
- [ ] hack `hardtime.nvim`, whose idea is cool, but don't get a good implementation
- [ ] lua annotations to fix annoying lsp messages
- [ ] PAGER mode for neovim, but no force center feature of pager

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

### Lua Patterns

In lua, `-` stands for non-greedy `*`; it is a metacharacter too.

### expr map pitfall

When you are creating a __expr mapping__ in __normal mode__, if you want special key like `<Nop>`, `<Left>`, make sure to escape them.

For me, I want to disable `q` recording binding most of times, because I always mispress it. The right code are below:

```lua
vim.keymap.set("n", "q", function()
  return vim.g.allow_recoring and "q" or "\\<NOP\\>"
end, { expr = true })
```

Note that a bare `'<Nop>'` tells vim to do ['<', 'N', 'o', 'p', '>'] one by one, which is not what we want.
