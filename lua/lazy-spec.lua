local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { import = "plugins" },
  { import = "plugins.langs" },
  { import = "plugins.ui" },
  { import = "plugins.utils" },
  { import = "plugins.navigation" },
  { import = "plugins.completion" },
}

local lazy_opts = {
  root = vim.fn.stdpath("data") .. "/lazy",
  defaults = {
    lazy = false,
    version = nil,
    cond = nil,
  },
  spec = nil,
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
  concurrency = jit.os:find("Windows") and (vim.uv.available_parallelism() * 2) or nil,
  git = {
    log = { "-8" },
    timeout = 120,
    url_format = "https://github.com/%s.git",
    filter = true,
  },
  dev = {
    path = "~/Projects/Neovims",
    patterns = {},
    fallback = false,
  },
  install = {
    missing = true,
    colorscheme = { "default" },
  },
  ui = {
    size = { width = 0.8, height = 0.8 },
    wrap = true,
    border = "none",
    backdrop = 60,
    title = nil,
    title_pos = "center",
    pills = true,
    icons = {
      cmd = " ",
      config = "",
      event = " ",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      require = "󰢱 ",
      source = " ",
      start = " ",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
    browser = nil,
    throttle = 20,
    custom_keys = {
      ["<localleader>l"] = false,
      ["<localleader>t"] = false,
    },
  },
  diff = {
    cmd = "git",
  },
  checker = {
    enabled = false,
    concurrency = nil,
    notify = false,
    frequency = 3600,
    check_pinned = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = {
        "gzip",
        "tutor",
        "tohtml",
        "zipPlugin",
        "tarPlugin",
      },
    },
  },
  readme = {
    enabled = true,
    root = vim.fn.stdpath("state") .. "/lazy/readme",
    files = { "README.md", "lua/**/README.md" },
    skip_if_doc_exists = false,
  },
  state = vim.fn.stdpath("state") .. "/lazy/state.json",
  build = {
    warn_on_override = true,
  },
  profiling = {
    loader = false,
    require = false,
  },
}

require("lazy").setup(plugins, lazy_opts)
