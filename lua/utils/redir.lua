-- credit
-- https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
vim.cmd([[
function! Redir(cmd, rng, start, end)
	for win in range(1, winnr('$'))
		if getwinvar(win, 'scratch')
			execute win . 'windo close'
		endif
	endfor
	if a:cmd =~ '^!'
		let cmd = a:cmd =~' %'
			\ ? matchstr(substitute(a:cmd, ' %', ' ' . shellescape(escape(expand('%:p'), '\')), ''), '^!\zs.*')
			\ : matchstr(a:cmd, '^!\zs.*')
		if a:rng == 0
			let output = systemlist(cmd)
		else
			let joined_lines = join(getline(a:start, a:end), '\n')
			let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
			let output = systemlist(cmd . " <<< $" . cleaned_lines)
		endif
	else
		redir => output
		execute a:cmd
		redir END
		let output = split(output, "\n")
	endif
	vnew
	let w:scratch = 1
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, output)
endfunction

" This command definition includes -bar, so that it is possible to "chain" Vim commands.
" Side effect: double quotes can't be used in external commands
command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)

" This command definition doesn't include -bar, so that it is possible to use double quotes in external commands.
" Side effect: Vim commands can't be "chained".
command! -nargs=1 -complete=command -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)
]])

local interepters = {
  python = "python",
  sh = "bash",
  bash = "bash",
  fish = "fish",
  lua = "luajit",
}

local function redir(range)
  return function()
    local ft = vim.o.ft
    local interepter = interepters[ft]
    if interepter then
      vim.cmd(string.format("%sRedir !%s", range, interepter))
    else
      vim.fn.setcmdline(string.format("%sRedir !", range))
    end
  end
end

vim.api.nvim_create_user_command("Mes", function()
  vim.cmd("Redir mes")
end, {})
vim.cmd([[cabbrev M Mes]])

vim.api.nvim_create_user_command("RedirEvalLine", redir("."), {})
vim.api.nvim_create_user_command("RedirEvalFile", redir("%"), {})
vim.api.nvim_create_user_command("RedirEvalRange", redir("'<.'>"), {})
