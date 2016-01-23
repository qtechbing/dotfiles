---------------
-- CONSTANTS --
---------------

local ctrl_alt = {"ctrl", "alt"}
local ctrl_alt_cmd = {"ctrl", "alt", "cmd"}
local alt_cmd = {"cmd", "alt"}


--------------------
-- CONFIGURATIONS --
--------------------

hs.window.animationDuration = 0

--------------------------------------------------------------------------------
-- LAYOUTS
-- SINTAX:
--  {
--    name = "App name" ou { "App name", "App name" }
--    func = function(index, win)
--      COMMANDS
--    end
--  },
--
-- It searches for application "name" and call "func" for each window object
--------------------------------------------------------------------------------


------------------
-- BASIC CONFIG --
------------------

function config()
   hs.hotkey.bind(ctrl_alt, "l", function()
                     local win = hs.window.focusedWindow()
                     win:right()
   end)

   hs.hotkey.bind(ctrl_alt, "j", function()
                     local win = hs.window.focusedWindow()
                     win:left()
   end)

   hs.hotkey.bind(ctrl_alt, "i", function()
                     local win = hs.window.focusedWindow()
                     win:up()
   end)

   hs.hotkey.bind(ctrl_alt, "k", function()
                     local win = hs.window.focusedWindow()
                     win:down()
   end)

   hs.hotkey.bind(ctrl_alt_cmd, "j", function()
                     local win = hs.window.focusedWindow()
                     win:upLeft()
   end)

   hs.hotkey.bind(ctrl_alt_cmd, "k", function()
                     local win = hs.window.focusedWindow()
                     win:downLeft()
   end)

   hs.hotkey.bind(ctrl_alt_cmd, "l", function()
                     local win = hs.window.focusedWindow()
                     win:downRight()
   end)

   hs.hotkey.bind(ctrl_alt_cmd, "i", function()
                     local win = hs.window.focusedWindow()
                     win:upRight()
   end)

   hs.hotkey.bind(ctrl_alt, "c", function()
                     local win = hs.window.focusedWindow()
                     win:fullscreenCenter()
   end)

   hs.hotkey.bind(ctrl_alt_cmd, "c", function()
                     local win = hs.window.focusedWindow()
                     win:fullscreenAlmostCenter()
   end)

   hs.hotkey.bind(ctrl_alt, "f", function()
                     local win = hs.window.focusedWindow()
                     win:maximize()
   end)

   hs.hotkey.bind(ctrl_alt_cmd, "h", function()
                     hs.hints.windowHints()
   end)

   hs.hotkey.bind(ctrl_alt_cmd, "R", function()
                     hs.reload()
                     hs.alert.show("Config loaded")
   end)

   hs.hotkey.bind(ctrl_alt, "m", function()
                     local win = hs.window.focusedWindow()
                     win:moveToScreen(hs.screen.theOtherScreen())
   end)

   hs.hotkey.bind(alt_cmd, "1", function ()
                     local macScreen = "Color LCD"
                     local layout = {
                        {"Safari", nil, macScreen, hs.layout.right50, nil, nil},
                        {"Emacs", nil, macScreen, hs.layout.left50, nil, nil}
                     }
                     hs.layout.apply(layout)
   end)

   hs.hotkey.bind(alt_cmd, "1", function ()
                     local macScreen = "Color LCD"
                     local layout = {
                        {"Safari", nil, macScreen, hs.layout.right50, nil, nil},
                        {"Emacs", nil, macScreen, hs.layout.left50, nil, nil}
                     }
                     hs.layout.apply(layout)
   end)
end

----------------------------
-- METHODS - BECAREFUL :) --
----------------------------

function hs.screen.theOtherScreen()
   local allScreens = hs.screen.allScreens()
   for i, screen in ipairs(allScreens) do
      if screen ~= hs.screen.mainScreen() then
         return screen
      end
   end
end

-- +-----------------+
-- |        |        |
-- |        |  HERE  |
-- |        |        |
-- +-----------------+
function hs.window.right(win)
   local currentFrame = win:screen():frame()
   currentFrame.x = currentFrame.x + (currentFrame.w/2)
   currentFrame.w = currentFrame.w/2
   win:setFrame(currentFrame)
end

-- +-----------------+
-- |        |        |
-- |  HERE  |        |
-- |        |        |
-- +-----------------+
function hs.window.left(win)
   local currentFrame = (win:screen()):frame()
   currentFrame.w = currentFrame.w/2
   win:setFrame(currentFrame)
end

-- +-----------------+
-- |      HERE       |
-- +-----------------+
-- |                 |
-- +-----------------+
function hs.window.up(win)
   local currentFrame = win:screen():frame()
   currentFrame.h = currentFrame.h/2
   win:setFrame(currentFrame)
end

-- +-----------------+
-- |                 |
-- +-----------------+
-- |      HERE       |
-- +-----------------+
function hs.window.down(win)
   local currentFrame = win:screen():frame()
   currentFrame.y = currentFrame.y + currentFrame.h/2
   currentFrame.h = currentFrame.h/2
   win:setFrame(currentFrame)
end

-- +-----------------+
-- |  HERE  |        |
-- +--------+        |
-- |                 |
-- +-----------------+
function hs.window.upLeft(win)
   local currentFrame = win:screen():frame()
   currentFrame.w = currentFrame.w/2
   currentFrame.h = currentFrame.h/2
   win:setFrame(currentFrame)
end

-- +-----------------+
-- |                 |
-- +--------+        |
-- |  HERE  |        |
-- +-----------------+
function hs.window.downLeft(win)
   local currentFrame = win:screen():frame()
   win:setFrame({
         x = currentFrame.x,
         y = currentFrame.y + currentFrame.h/2,
         w = currentFrame.w/2,
         h = currentFrame.h/2
   })
end

-- +-----------------+
-- |                 |
-- |        +--------|
-- |        |  HERE  |
-- +-----------------+
function hs.window.downRight(win)
   local currentFrame = win:screen():frame()
   win:setFrame({
         x = currentFrame.x + currentFrame.w/2,
         y = currentFrame.y + currentFrame.h/2,
         w = currentFrame.w/2,
         h = currentFrame.h/2
   })
end

-- +-----------------+
-- |        |  HERE  |
-- |        +--------|
-- |                 |
-- +-----------------+
function hs.window.upRight(win)
   local currentFrame = win:screen():frame()
   win:setFrame({
         x = currentFrame.x + currentFrame.w/2,
         y = currentFrame.y,
         w = currentFrame.w/2,
         h = currentFrame.h/2
   })
end

-- +------------------+
-- |                  |
-- |    +--------+    +--> minY
-- |    |  HERE  |    |
-- |    +--------+    |
-- |                  |
-- +------------------+
-- Where the window's size is equal to
-- the smaller available screen size
function hs.window.fullscreenCenter(win)
   local currentFrame = win:screen():frame()
   win:setFrame(currentFrame)
end

-- +------------------+
-- |                  |
-- |  +------------+  +--> minY
-- |  |    HERE    |  |
-- |  +------------+  |
-- |                  |
-- +------------------+
function hs.window.fullscreenAlmostCenter(win)
   local offsetW = win:screen():minX() - win:screen():almostMinX()
   win:setFrame({
         x = win:screen():almostMinX(),
         y = win:screen():minY(),
         w = hs.screen.minWidth(isFullscreen) + (2 * offsetW),
         h = hs.screen.minHeight(isFullscreen)
   })
end

-- It like fullscreen but with minY and minHeight values
-- +------------------+
-- |                  |
-- +------------------+--> minY
-- |       HERE       |
-- +------------------+--> minHeight
-- |                  |
-- +------------------+
function hs.window.fullscreenWidth(win)
   local currentFrame = win:screen():frame()
   win:setFrame({
         x = win:screen():frame().x,
         y = currentFrame.y,
         w = win:screen():frame().w,
         h = currentFrame.h
   })
end

function applicationWatcher(appName, eventType, appObject)
   if (eventType == hs.application.watcher.activated) then
      if (appName == "iTerm") then
         appObject:selectMenuItem({"Window", "Bring All to Front"})
      elseif (appName == "Finder") then
         appObject:selectMenuItem({"Window", "Bring All to Front"})
      elseif (appName == "Finder") then
         appObject:selectMenuItem({"Window", "Bring All to Front"})
      end
   end

   if (eventType == hs.application.watcher.launched) then

      os.execute("sleep " .. tonumber(2))

      if (appObject) then
         local wins = appObject:allWindows()
         for j, win in ipairs(wins) do
            hs.alert.show(win:title())
         end
      end

      applyLayout(layouts, appObject)
   end
end

config()
-- local appWatcher = hs.application.watcher.new(applicationWatcher)
-- appWatcher:start()
