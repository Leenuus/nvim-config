-- fix cursor type in Tmux
vim.cmd([[
augroup cursor
	autocmd!
	" reset cursor on start:
	autocmd VimEnter * silent !echo -ne "\e[2 q"
	autocmd VimEnter * set cursorline
	autocmd VimEnter * set cursorcolumn
	" cursor blinking bar on insert mode
	let &t_SI = "\e[5 q"
	" cursor steady block on command mode
	let &t_EI = "\e[2 q"
	autocmd VimLeave * set guicursor=a:ver90
augroup END
]])
