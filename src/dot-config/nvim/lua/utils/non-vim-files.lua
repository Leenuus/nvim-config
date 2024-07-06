vim.g.open_non_vim_file = true

local opener = function(prog)
  return function(buf, file)
    local cmd = string.format("silent !%s %s >/dev/null 2>&1 &", prog, vim.fn.shellescape(file))
    vim.cmd(cmd)
    vim.cmd("buffer#")
    vim.api.nvim_buf_delete(buf, { force = true })
  end
end

local xdg_open = opener("xdg-open")

-- handler = xdg_handler,
local external_exts = {
  -- video
  "avi",
  "mp4",
  "mkv",
  "mov",
  "mpg",
  -- document
  "pdf",
  "epub",
  "azw3",
  "djvu",
  "epub",
  "mobi",
  "ps",
  -- image
  "ico",
  "jpg",
  "png",
  "webp",
  -- audio
  "aac",
  "flac",
  "m4a",
  "mp3",
  "oga",
  "opus",
  "wav",
}

vim.api.nvim_create_autocmd("BufReadPre", {
  group = vim.api.nvim_create_augroup("open-non-vim-file", { clear = true }),
  callback = function(event)
    local f = event.match
    -- print(vim.inspect(event))
    local ext = f:match("%.(.*)$")

    if not vim.g.open_non_vim_file then
      return
    end

    for _, eext in ipairs(external_exts) do
      if type(eext) == "table" then
        if ext == eext[1] then
          eext["opener"](event.buf, f)
        end
      elseif type(eext) == "string" then
        if ext == eext then
          xdg_open(event.buf, f)
        end
      end
    end
  end,
})

require("helpers").toggler("open_non_vim_file", "OpenNonVimFile", false)
