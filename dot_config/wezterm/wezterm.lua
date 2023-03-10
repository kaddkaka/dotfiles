local w = require 'wezterm'
local a = w.action

local function isViProcess(pane)
    return pane:get_foreground_process_name():find('n?vim') ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
    if isViProcess(pane) then
        window:perform_action(a.SendKey({ key = vim_direction, mods = 'ALT' }), pane)
    else
        window:perform_action(a.ActivatePaneDirection(pane_direction), pane)
    end
end

w.on('ActivatePaneDirection-right', function(window, pane)
    conditionalActivatePane(window, pane, 'Right', 'l')
end)
w.on('ActivatePaneDirection-left', function(window, pane)
    conditionalActivatePane(window, pane, 'Left', 'h')
end)

return {
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  adjust_window_size_when_changing_font_size = false,
  mouse_bindings = {
    {
      event = { Down = { streak = 3, button = 'Left' } },
      action = a.SelectTextAtMouseCursor 'SemanticZone',
    },
  },
  keys = {
    { key = "UpArrow",   mods = "SHIFT", action = a.ScrollToPrompt(-1) },
    { key = "DownArrow", mods = "SHIFT", action = a.ScrollToPrompt( 1) },

    { key = 'o', mods = "ALT",       action = a.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = 'h', mods = 'ALT',       action = a.EmitEvent('ActivatePaneDirection-left') },
    { key = 'l', mods = 'ALT',       action = a.EmitEvent('ActivatePaneDirection-right') },
    { key = "h", mods = "ALT|SHIFT", action = a.AdjustPaneSize { "Left", 10 } },
    { key = "l", mods = "ALT|SHIFT", action = a.AdjustPaneSize { "Right", 10 } },
  },
}
