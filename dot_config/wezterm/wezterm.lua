local w = require 'wezterm'
local a = w.action
local cb = w.action_callback

local function is_inside_vim(pane)
  local tty = pane:get_tty_name()
  if tty == nil then return false end

  local success, stdout, stderr = w.run_child_process
    { 'sh', '-c',
      'ps -o state= -o comm= -t' .. w.shell_quote_arg(tty) .. ' | ' ..
      'grep -iqE \'^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$\'' }
      --'grep -q \'S nvim\'' }

  return success
end

local function Navigate(win, pane, key, dir)
  if is_inside_vim(pane) then
    win:perform_action(a.SendKey {key = key, mods = 'ALT'}, pane)
  else
    win:perform_action(a.ActivatePaneDirection(dir), pane)
  end
end

return {
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  adjust_window_size_when_changing_font_size = false,
  mouse_bindings = {
    {
      event = { Down = { streak = 3, button = 'Right' } },
      action = a.SelectTextAtMouseCursor 'SemanticZone',
    },
  },
  keys = {
    { key = "UpArrow",   mods = "SHIFT", action = a.ScrollToPrompt(-1) },
    { key = "DownArrow", mods = "SHIFT", action = a.ScrollToPrompt( 1) },

    { key = 'o', mods = "ALT", action = a.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = 'h', mods = 'ALT', action = cb(function(win, pane) Navigate(win, pane, 'h', 'Left')  end) },
    { key = 'l', mods = 'ALT', action = cb(function(win, pane) Navigate(win, pane, 'l', 'Right') end) },

    { key = "h", mods = "ALT|SHIFT", action = a.AdjustPaneSize { "Left",  10 } },
    { key = "l", mods = "ALT|SHIFT", action = a.AdjustPaneSize { "Right", 10 } },
  },
}
