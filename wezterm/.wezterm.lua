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
config.window_background_opacity = 0.8
config.scrollback_lines = 3000
config.use_ime = true
config.window_close_confirmation = 'NeverPrompt'

-- padding
config.window_padding = {
  left = 16,
  right = 16,
  top = 16,
  bottom = 16,
}

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.5,
}

-- config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- Tmux-like keybindings
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

keys = {
  -- Split panes
  { key = '"', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = '%', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },

  -- Move between panes
  { key = 'h', mods = 'LEADER',       action = act.ActivatePaneDirection('Left') },
  { key = 'j', mods = 'LEADER',       action = act.ActivatePaneDirection('Down') },
  { key = 'k', mods = 'LEADER',       action = act.ActivatePaneDirection('Up') },
  { key = 'l', mods = 'LEADER',       action = act.ActivatePaneDirection('Right') },
  -- Adjust pane size
  { key = "H", mods = "LEADER",       action = act.AdjustPaneSize { "Left", 15 } },
  { key = "J", mods = "LEADER",       action = act.AdjustPaneSize { "Down", 15 } },
  { key = "K", mods = "LEADER",       action = act.AdjustPaneSize { "Up", 15 } },
  { key = "L", mods = "LEADER",       action = act.AdjustPaneSize { "Right", 15 } },
  -- Zoom
  { key = 'z', mods = 'LEADER',       action = 'TogglePaneZoomState' },
  -- Spawn Tab
  { key = 'c', mods = 'LEADER',       action = act.SpawnTab('CurrentPaneDomain') },
  -- Reload config
  { key = 'r', mods = 'LEADER',       action = 'ReloadConfiguration' },
  -- Close pane
  { key = 'x', mods = 'LEADER',       action = act.CloseCurrentPane { confirm = true } },
  -- Copy mode
  { key = '[', mods = 'LEADER',       action = act.ActivateCopyMode },
  -- Paste
  { key = ']', mods = 'LEADER',       action = act.PasteFrom "PrimarySelection" },
  -- Navigation
  { key = "1", mods = 'LEADER',       action = act.ActivateTab(0) },
  { key = "2", mods = 'LEADER',       action = act.ActivateTab(1) },
  { key = "3", mods = 'LEADER',       action = act.ActivateTab(2) },
  { key = "4", mods = 'LEADER',       action = act.ActivateTab(3) },
  { key = "5", mods = 'LEADER',       action = act.ActivateTab(4) },
  { key = "6", mods = 'LEADER',       action = act.ActivateTab(5) },
  { key = "7", mods = 'LEADER',       action = act.ActivateTab(6) },
  { key = "8", mods = 'LEADER',       action = act.ActivateTab(7) },
  { key = "9", mods = 'LEADER',       action = act.ActivateTab(8) },
  { key = "0", mods = 'LEADER',       action = act.ActivateTab(9) },
}

local copy_mode_keys = {
  { key = "c",          mods = "CTRL",  action = act.CopyMode("Close") },
  { key = "g",          mods = "CTRL",  action = act.CopyMode("Close") },
  { key = "q",          mods = "NONE",  action = act.CopyMode("Close") },
  { key = "Escape",     mods = "NONE",  action = act.CopyMode("Close") },

  { key = "h",          mods = "NONE",  action = act.CopyMode("MoveLeft") },
  { key = "j",          mods = "NONE",  action = act.CopyMode("MoveDown") },
  { key = "k",          mods = "NONE",  action = act.CopyMode("MoveUp") },
  { key = "l",          mods = "NONE",  action = act.CopyMode("MoveRight") },

  { key = "LeftArrow",  mods = "NONE",  action = act.CopyMode("MoveLeft") },
  { key = "DownArrow",  mods = "NONE",  action = act.CopyMode("MoveDown") },
  { key = "UpArrow",    mods = "NONE",  action = act.CopyMode("MoveUp") },
  { key = "RightArrow", mods = "NONE",  action = act.CopyMode("MoveRight") },

  { key = "RightArrow", mods = "ALT",   action = act.CopyMode("MoveForwardWord") },
  { key = "f",          mods = "ALT",   action = act.CopyMode("MoveForwardWord") },
  { key = "Tab",        mods = "NONE",  action = act.CopyMode("MoveForwardWord") },
  { key = "w",          mods = "NONE",  action = act.CopyMode("MoveForwardWord") },

  { key = "LeftArrow",  mods = "ALT",   action = act.CopyMode("MoveBackwardWord") },
  { key = "b",          mods = "ALT",   action = act.CopyMode("MoveBackwardWord") },
  { key = "Tab",        mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
  { key = "b",          mods = "NONE",  action = act.CopyMode("MoveBackwardWord") },

  { key = "0",          mods = "NONE",  action = act.CopyMode("MoveToStartOfLine") },
  { key = "Enter",      mods = "NONE",  action = act.CopyMode("MoveToStartOfNextLine") },

  { key = "$",          mods = "NONE",  action = act.CopyMode("MoveToEndOfLineContent") },
  { key = "$",          mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
  { key = "^",          mods = "NONE",  action = act.CopyMode("MoveToStartOfLineContent") },
  { key = "^",          mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
  { key = "m",          mods = "ALT",   action = act.CopyMode("MoveToStartOfLineContent") },

  { key = " ",          mods = "NONE",  action = act.CopyMode { SetSelectionMode = "Cell" } },
  { key = "v",          mods = "NONE",  action = act.CopyMode { SetSelectionMode = "Cell" } },
  { key = "V",          mods = "NONE",  action = act.CopyMode { SetSelectionMode = "Line" } },
  { key = "V",          mods = "SHIFT", action = act.CopyMode { SetSelectionMode = "Line" } },
  { key = "v",          mods = "CTRL",  action = act.CopyMode { SetSelectionMode = "Block" } },

  { key = "G",          mods = "NONE",  action = act.CopyMode("MoveToScrollbackBottom") },
  { key = "G",          mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
  { key = "g",          mods = "NONE",  action = act.CopyMode("MoveToScrollbackTop") },

  { key = "H",          mods = "NONE",  action = act.CopyMode("MoveToViewportTop") },
  { key = "H",          mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
  { key = "M",          mods = "NONE",  action = act.CopyMode("MoveToViewportMiddle") },
  { key = "M",          mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
  { key = "L",          mods = "NONE",  action = act.CopyMode("MoveToViewportBottom") },
  { key = "L",          mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },

  { key = "o",          mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEnd") },
  { key = "O",          mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
  { key = "O",          mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },

  { key = "PageUp",     mods = "NONE",  action = act.CopyMode("PageUp") },
  { key = "PageDown",   mods = "NONE",  action = act.CopyMode("PageDown") },

  { key = "b",          mods = "CTRL",  action = act.CopyMode("PageUp") },
  { key = "f",          mods = "CTRL",  action = act.CopyMode("PageDown") },

  -- Enter y to copy and quit the copy mode.
  {
    key = "y",
    mods = "NONE",
    action = act.Multiple {
      act.CopyTo("ClipboardAndPrimarySelection"),
      act.CopyMode("Close"),
    }
  },
  -- Enter search mode to edit the pattern.
  -- When the search pattern is an empty string the existing pattern is preserved
  { key = "/", mods = "NONE", action = act { Search = { CaseSensitiveString = "" } } },
  { key = "?", mods = "NONE", action = act { Search = { CaseInSensitiveString = "" } } },
  { key = "n", mods = "CTRL", action = act { CopyMode = "NextMatch" } },
  { key = "p", mods = "CTRL", action = act { CopyMode = "PriorMatch" } },

}

--- Set Pwsh as the default on Windows
config.default_prog = { 'pwsh.exe' }
config.keys = keys

config.key_tables = {
  copy_mode = copy_mode_keys,
}

return config
