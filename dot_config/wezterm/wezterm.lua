local w = require 'wezterm'
local a = w.action

return {
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  mouse_bindings = {
    {
      event = { Down = { streak = 3, button = 'Left' } },
      action = w.action.SelectTextAtMouseCursor 'SemanticZone',
    },
  },
  keys = {
    { key = "UpArrow",   mods = "SHIFT", action = a.ScrollToPrompt(-1) },
    { key = "DownArrow", mods = "SHIFT", action = a.ScrollToPrompt( 1) },

    { key = 'o', mods = "ALT",       action = a.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = "h", mods = "ALT",       action = a.ActivatePaneDirection("Left") },
    { key = "l", mods = "ALT",       action = a.ActivatePaneDirection("Right") },
    { key = "h", mods = "ALT|SHIFT", action = a.AdjustPaneSize { "Left", 10 } },
    { key = "l", mods = "ALT|SHIFT", action = a.AdjustPaneSize { "Right", 10 } },
  },
}
