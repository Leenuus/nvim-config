local extension = {
  todo = "markdown",
  sshconfig = "sshconfig",
}

local pattern = {
  -- [".*/etc/foo/.*"] = "fooscript",
  -- Using an optional priority
  -- [".*/etc/foo/.*%.conf"] = { "dosini", { priority = 10 } },
  -- A pattern containing an environment variable
  -- ["${XDG_CONFIG_HOME}/foo/git"] = "git",
  -- ["README.(a+)$"] = function(path, bufnr, ext)
  --   if ext == "md" then
  --     return "markdown"
  --   elseif ext == "rst" then
  --     return "rst"
  --   end
  -- end,
}

local filename = {
  ["urls"] = "rssfeed",
  -- ["/etc/foo/config"] = "toml",
}

vim.filetype.add({
  extension = extension,
  pattern = pattern,
  filename = filename
})
