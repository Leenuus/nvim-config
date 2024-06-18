-- TODO: center results, smaller window width, and disable previewer, toggle previewer bindings
return {
  layout_strategy = "center",
  layout_config = {
    center = {
      height = 0.7,
      preview_cutoff = 40,
      prompt_position = "bottom",
      width = 0.5,
    },
    bottom_pane = {
      height = 25,
      preview_cutoff = 120,
      prompt_position = "top",
    },
    cursor = {
      height = 0.9,
      preview_cutoff = 40,
      width = 0.8,
    },
    horizontal = {
      height = 0.9,
      preview_cutoff = 120,
      prompt_position = "bottom",
      width = 0.8,
    },
    vertical = {
      height = 0.9,
      preview_cutoff = 40,
      prompt_position = "bottom",
      width = 0.8,
    },
  },
  mappings = require("config.tele.mapping"),
}
