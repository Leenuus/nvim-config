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
}
