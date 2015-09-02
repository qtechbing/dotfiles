require "pomodoor"
-- hotkey mash
local mash = {"ctrl", "alt"}

-- disable animation
hs.window.animationDuration = 0

-- Hello
hs.hotkey.bind({"cmd", "alt", "ctrl"} , "H", function ()
      hs.notify.new({title="Hammerspoon", informativeText="Hello! I am Baymax. I am your personal health care."}):send():release()
end)

-- marginalization
hs.hotkey.bind(mash, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind(mash, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind(mash, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind(mash, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind(mash, 'F', hs.grid.maximizeWindow)

-- change focus
hs.hotkey.bind(mash, 'H', function() hs.window.focusedWindow():focusWindowWest() end)
hs.hotkey.bind(mash, 'L', function() hs.window.focusedWindow():focusWindowEast() end)
hs.hotkey.bind(mash, 'K', function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(mash, 'J', function() hs.window.focusedWindow():focusWindowSouth() end)

-- Window Hints
hs.hotkey.bind(mash, '.', hs.hints.windowHints)

-- pomodoro key binding
hs.hotkey.bind(mash, '9', function() pom_enable() end)
hs.hotkey.bind(mash, '0', function() pom_disable() end)
