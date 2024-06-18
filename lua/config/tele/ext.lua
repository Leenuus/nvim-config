local project = {
  base_dirs = {
    { "~/Projects",               max_depth = 1 },
    { "~/.local/share/nvim/lazy", max_depth = 1 },
  },
  hidden_files = false,
  theme = "dropdown",
  order_by = "asc",
  search_by = "title",
  sync_with_nvim_tree = false,
  on_project_selected = function(prompt_bufnr)
    local p_actions = require("telescope._extensions.project.actions")
    p_actions.change_working_directory(prompt_bufnr)
    vim.cmd("QuickFiles")
  end,
}

return {
  ["ui-select"] = {
    require("telescope.themes").get_dropdown({}),
  },
  fzf = {
    fuzzy = true,
    override_generic_sorter = true,
    override_file_sorter = true,
    case_mode = "smart_case",
  },
  project = project,
}
