---------------
-- CONSTANTS --
---------------

local cmd_alt = {"cmd", "alt"}
local cmd_alt_ctrl = {"cmd", "alt", "ctrl"}

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

function config()
   hs.hotkey.bind(cmd_alt, "right", function()
                     local win = hs.window.focusedWindow()
                     win:right()
   end)

   hs.hotkey.bind(cmd_alt, "left", function()
                     local win = hs.window.focusedWindow()
                     win:left()
   end)

   hs.hotkey.bind(cmd_alt, "up", function()
                     local win = hs.window.focusedWindow()
                     win:up()
   end)

   hs.hotkey.bind(cmd_alt, "down", function()
                     local win = hs.window.focusedWindow()
                     win:down()
   end)

   hs.hotkey.bind(cmd_alt_ctrl, "left", function()
                     local win = hs.window.focusedWindow()
                     win:upLeft()
   end)

   hs.hotkey.bind(cmd_alt_ctrl, "down", function()
                     local win = hs.window.focusedWindow()
                     win:downLeft()
   end)

   hs.hotkey.bind(cmd_alt_ctrl, "right", function()
                     local win = hs.window.focusedWindow()
                     win:downRight()
   end)

   hs.hotkey.bind(cmd_alt_ctrl, "up", function()
                     local win = hs.window.focusedWindow()
                     win:upRight()
   end)

   hs.hotkey.bind(cmd_alt, "c", function()
                     local win = hs.window.focusedWindow()
                     win:fullscreenCenter()
   end)

   hs.hotkey.bind(cmd_alt_ctrl, "c", function()
                     local win = hs.window.focusedWindow()
                     win:fullscreenAlmostCenter()
   end)

   hs.hotkey.bind(cmd_alt, "f", function()
                     local win = hs.window.focusedWindow()
                     win:maximize()
   end)

   hs.hotkey.bind(cmd_alt_ctrl, "f", function()
                     local win = hs.window.focusedWindow()
                     if (win) then
                        win:fullscreenWidth()
                     end
   end)

   hs.hotkey.bind(cmd_alt_ctrl, "h", function()
                     hs.hints.windowHints()
   end)

   hs.hotkey.bind(cmd_alt_ctrl, "R", function()
                     hs.reload()
                     hs.alert.show("Config loaded")
   end)

   -- Safari tab keys
   hs.hotkey.bind({"cmd"}, "1", function()
         hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 1')
   end)
   hs.hotkey.bind({"cmd"}, "2", function()
         hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 2')
   end)
   hs.hotkey.bind({"cmd"}, "3", function()
         hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 3')
   end)
   hs.hotkey.bind({"cmd"}, "4", function()
         hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 4')
   end)
   hs.hotkey.bind({"cmd"}, "5", function()
         hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 5')
   end)
   hs.hotkey.bind({"cmd"}, "6", function()
         hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 6')
   end)
   hs.hotkey.bind({"cmd"}, "7", function()
         hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 7')
   end)
   hs.hotkey.bind({"cmd"}, "8", function()
         hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 8')
   end)
   hs.hotkey.bind({"cmd"}, "9", function()
         hs.applescript._applescript('tell front window of app "Safari" to set current tab to tab 9')
   end)
end

-----------------------
-- END CONFIGURATION --
-----------------------

----------------------------
-- METHODS - BECAREFUL :) --
----------------------------

function applyLayout(layouts, app)
   if (app) then
      local appName = app:title()
      for i, layout in ipairs(layouts) do
         if (type(layout.name) == "table") then
            for i, layAppName in ipairs(layout.name) do
               if (layAppName == appName) then
                  local wins = app:allWindows()
                  local counter = 1
                  for j, win in ipairs(wins) do
                     if (win:isVisible() and layout.func) then
                        layout.func(counter, win)
                        counter = counter + 1
                     end
                  end
               end
            end
         elseif (type(layout.name) == "string") then
            if (layout.name == appName) then
               local wins = app:allWindows()
               local counter = 1
               for j, win in ipairs(wins) do
                  if (win:isVisible() and layout.func) then
                     layout.func(counter, win)
                     counter = counter + 1
                  end
               end
            end
         end
      end
   end
end

function applyLayouts(layouts)
   for i, layout in ipairs(layouts) do
      if (type(layout.name) == "table") then
         for i, appName in ipairs(layout.name) do
            local app = hs.appfinder.appFromName(appName)
            if (app) then
               local wins = app:allWindows()
               local counter = 1
               for j, win in ipairs(wins) do
                  if (win:isVisible() and layout.func) then
                     layout.func(counter, win)
                     counter = counter + 1
                  end
               end
            end
         end
      elseif (type(layout.name) == "string") then
         local app = hs.appfinder.appFromName(layout.name)
         if (app) then
            local wins = app:allWindows()
            local counter = 1
            for j, win in ipairs(wins) do
               if (win:isVisible() and layout.func) then
                  layout.func(counter, win)
                  counter = counter + 1
               end
            end
         end
      end
   end
end

function hs.screen.get(screen_name)
   local allScreens = hs.screen.allScreens()
   for i, screen in ipairs(allScreens) do
      if screen:name() == screen_name then
         return screen
      end
   end
end

-- Returns the width of the smaller screen size
-- isFullscreen = false removes the toolbar
-- and dock sizes
function hs.screen.minWidth(isFullscreen)
   local min_width = math.maxinteger
   local allScreens = hs.screen.allScreens()
   for i, screen in ipairs(allScreens) do
      local screen_frame = screen:frame()
      if (isFullscreen) then
         screen_frame = screen:fullFrame()
      end
      min_width = math.min(min_width, screen_frame.w)
   end
   return min_width
end

-- isFullscreen = false removes the toolbar
-- and dock sizes
-- Returns the height of the smaller screen size
function hs.screen.minHeight(isFullscreen)
   local min_height = math.maxinteger
   local allScreens = hs.screen.allScreens()
   for i, screen in ipairs(allScreens) do
      local screen_frame = screen:frame()
      if (isFullscreen) then
         screen_frame = screen:fullFrame()
      end
      min_height = math.min(min_height, screen_frame.h)
   end
   return min_height
end

-- If you are using more than one monitor, returns X
-- considering the reference screen minus smaller screen
-- = (MAX_REFSCREEN_WIDTH - MIN_AVAILABLE_WIDTH) / 2
-- If using only one monitor, returns the X of ref screen
function hs.screen.minX(refScreen)
   local min_x = refScreen:frame().x
   local allScreens = hs.screen.allScreens()
   if (#allScreens > 1) then
      min_x = refScreen:frame().x + ((refScreen:frame().w - hs.screen.minWidth()) / 2)
   end
   return min_x
end

-- If you are using more than one monitor, returns Y
-- considering the focused screen minus smaller screen
-- = (MAX_REFSCREEN_HEIGHT - MIN_AVAILABLE_HEIGHT) / 2
-- If using only one monitor, returns the Y of focused screen
function hs.screen.minY(refScreen)
   local min_y = refScreen:frame().y
   local allScreens = hs.screen.allScreens()
   if (#allScreens > 1) then
      min_y = refScreen:frame().y + ((refScreen:frame().h - hs.screen.minHeight()) / 2)
   end
   return min_y
end

-- If you are using more than one monitor, returns the
-- half of minX and 0
-- = ((MAX_REFSCREEN_WIDTH - MIN_AVAILABLE_WIDTH) / 2) / 2
-- If using only one monitor, returns the X of ref screen
function hs.screen.almostMinX(refScreen)
   local min_x = refScreen:frame().x
   local allScreens = hs.screen.allScreens()
   if (#allScreens > 1) then
      min_x = refScreen:frame().x + (((refScreen:frame().w - hs.screen.minWidth()) / 2) - ((refScreen:frame().w - hs.screen.minWidth()) / 4))
   end
   return min_x
end

-- If you are using more than one monitor, returns the
-- half of minY and 0
-- = ((MAX_REFSCREEN_HEIGHT - MIN_AVAILABLE_HEIGHT) / 2) / 2
-- If using only one monitor, returns the Y of ref screen
function hs.screen.almostMinY(refScreen)
   local min_y = refScreen:frame().y
   local allScreens = hs.screen.allScreens()
   if (#allScreens > 1) then
      min_y = refScreen:frame().y + (((refScreen:frame().h - hs.screen.minHeight()) / 2) - ((refScreen:frame().h - hs.screen.minHeight()) / 4))
   end
   return min_y
end

-- Returns the frame of the smaller available screen
-- considering the context of refScreen
-- isFullscreen = false removes the toolbar
-- and dock sizes
function hs.screen.minFrame(refScreen, isFullscreen)
   return {
      x = refScreen:minX(),
      y = refScreen:minY(),
      w = hs.screen.minWidth(isFullscreen),
      h = hs.screen.minHeight(isFullscreen)
   }
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
local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

----------------
-- SAFARI TAB --
----------------

