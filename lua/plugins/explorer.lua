-- TODO: a better alternative to create files and navigate it
-- I can build it my own
-- especially for the `file creator part`
-- I want one open a floating window prompt me for file name
return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        -- vim.keymap.set('n', '<Enter>', function()
        --   api.node.open.edit()
        --   api.tree.close()
        -- end)
        -- vim.keymap.set('n', 'l', api.node.open.edit, { buffer = true })
        -- vim.keymap.set('n', 'h', api.node.navigate.parent_close, { buffer = true })
      end,
      filters = { custom = { "^.git$" } },
    })
  end,
}
