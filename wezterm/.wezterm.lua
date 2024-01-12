local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}
local keys = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font 'MesloLGM Nerd Font'
-- config.color_scheme = 'Dark Ocean (terminal.sexy)'
config.color_scheme = 'darkmoss (base16)'
-- config.window_background_opacity = 0.8
config.scrollback_lines = 6000
config.window_close_confirmation = 'NeverPrompt'

-- Tmux-like keybindings
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

keys = {
  -- Split panes
  { key = '%', mods = 'LEADER|SHIFT', action = wezterm.action { SplitVertical = { domain = 'CurrentPaneDomain' } } },
  { key = '"', mods = 'LEADER|SHIFT', action = wezterm.action { SplitHorizontal = { domain = 'CurrentPaneDomain' } } },
  -- Move between panes
  { key = 'h', mods = 'LEADER', action = wezterm.action { ActivatePaneDirection = 'Left' } },
  { key = 'j', mods = 'LEADER', action = wezterm.action { ActivatePaneDirection = 'Down' } },
  { key = 'k', mods = 'LEADER', action = wezterm.action { ActivatePaneDirection = 'Up' } },
  { key = 'l', mods = 'LEADER', action = wezterm.action { ActivatePaneDirection = 'Right' } },
  -- Zoom
  { key = 'z', mods = 'LEADER', action = 'TogglePaneZoomState' },
  -- Copy mode
  { key = 'c', mods = 'LEADER', action = 'ActivateCopyMode' },
  -- Reload config
  { key = 'r', mods = 'LEADER', action = 'ReloadConfiguration' },
  -- Close pane
  { key = 'x', mods = 'LEADER', action = { CloseCurrentPane = { confirm = true } } },
  -- New tab
  { key = 't', mods = 'LEADER', action = { SpawnTab = 'CurrentPaneDomain' } },
}

--- Set Pwsh as the default on Windows
config.default_prog = { 'pwsh.exe' }
config.keys = keys

return config
