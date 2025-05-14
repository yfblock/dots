-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

config.window_decorations = "NONE"
config.window_background_opacity = 0.8
config.text_background_opacity = 0.8
config.hide_tab_bar_if_only_one_tab = true
-- For example, changing the initial geometry for new windows:
-- config.initial_cols = 120
-- config.initial_rows = 28

-- or, changing the font size and color scheme.
-- config.font_size = 10
-- config.color_scheme = 'AdventureTime'

-- Finally, return the configuration to wezterm:
return config
