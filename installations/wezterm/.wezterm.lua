local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("JetBrains Mono", { weight = "Regular", italic = false })
config.color_scheme = "Tokyo Night"
config.font_size = 14
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.enable_tab_bar = false

return config
