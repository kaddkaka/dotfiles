local w = require 'wezterm'
local a = w.action

local function is_inside_vim(pane)
  local tty = pane:get_tty_name()
  if tty == nil then return false end
  local success, stdout, stderr = w.run_child_process { 'sh', '-c',
      'ps -o state= -o comm= -t' .. w.shell_quote_arg(tty) .. ' | ' ..
      'grep -iqE \'^[^TXZ ]+ +(\\S+\\/)?g?(view|l?nvim?x?)(diff)?$\'' }
  return success
end
local function is_outside_vim(pane) return not is_inside_vim(pane) end

local function bind_if(cond, key, mods, action)
  local function callback (win, pane)
    if cond(pane) then
      win:perform_action(action, pane)
    else
      win:perform_action(a.SendKey({key=key, mods=mods}), pane)
    end
  end
  return {key=key, mods=mods, action=w.action_callback(callback)}
end

local function toggle(key, value)
  return w.action_callback( function (window, pane)
    local o = window:get_config_overrides() or {}
    if o[key] then o[key] = nil else o[key] = value end
    window:set_config_overrides(o)
  end )
end

return {
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  window_decorations = "NONE",
  front_end = "OpenGL",
  use_fancy_tab_bar = false,
  window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
  adjust_window_size_when_changing_font_size = false,
  inactive_pane_hsb = { saturation = 1, brightness = 1 },  -- s0.9, b0.8

  color_scheme = 'nord',
  force_reverse_video_cursor = true,
  mouse_bindings = { {
      event = { Down = { streak = 3, button = 'Right' } },
      action = a.SelectTextAtMouseCursor 'SemanticZone',
  }, },
  keys = {
    bind_if(is_outside_vim, 'UpArrow', 'SHIFT', a.ScrollToPrompt(-1)),
    bind_if(is_outside_vim, 'DownArrow', 'SHIFT', a.ScrollToPrompt(1)),

    { key = 'o', mods = "ALT", action = a.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
    bind_if(is_outside_vim, 'h', 'ALT', a.ActivatePaneDirection('Left')),
    bind_if(is_outside_vim, 'l', 'ALT', a.ActivatePaneDirection('Right')),

    { key = "h", mods = "ALT|SHIFT", action = a.AdjustPaneSize { "Left",  10 } },
    { key = "l", mods = "ALT|SHIFT", action = a.AdjustPaneSize { "Right", 10 } },

    { key = "p", mods = "ALT", action = toggle('color_scheme', 'Atelier Dune Light (base16)') },
  },
}
