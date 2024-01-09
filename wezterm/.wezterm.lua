local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font 'MesloLGM Nerd Font'
config.color_scheme = 'MonaLisa'
-- config.window_background_opacity = 0.8
config.scrollback_lines = 6000

--- Set Pwsh as the default on Windows
config.default_prog = { 'pwsh.exe' }


return config
