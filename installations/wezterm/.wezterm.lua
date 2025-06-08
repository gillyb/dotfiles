local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("JetBrains Mono", { weight = "Bold", italic = false })
config.color_scheme = "Tokyo Night"
-- config.color_scheme = "Tokyo Night"
-- config.font_rules = {
-- 	italic = true,
-- 	-- font = wezterm.font("Operator Mono", { weight = 325, italic = true }),
-- }
config.font_size = 14
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

return config
