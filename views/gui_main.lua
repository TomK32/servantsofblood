
require('views/view')
require('views/list_view')
require('views/map_view')
require('views/compass_view')
require('views/runners_view')
require('views/instructions_view')
GUIMain = class("GUIMain")
function GUIMain:initialize(sgame_state)

end

function GUIMain:reset()
  self.game_state = game_state

  local map_width = (love.graphics.getWidth() - ListView.display.width) / #game_state.players
  self.display = {x = map_width, y = 148}

  -- compass on top, any other info view below that
  self.compass_views = {}
  self.map_views = {}
  for i, player in pairs(game_state.players) do
    local compass_view = CompassView()
    compass_view.player = player
    compass_view.display.x = self.display.x
    if #self.compass_views > 0 then
      compass_view.display.y = self.compass_views[#self.compass_views].display.y + self.compass_views[#self.compass_views].display.height
    end
    table.insert(self.compass_views, compass_view)
    player.compass_view = compass_view

    map_view = MapView(game_state.map)
    map_view.display.x = map_width * (i - 1)
    map_view.display.width = map_width
    if i > 1 then
      map_view.display.x = map_view.display.width + ListView.display.width
    end
    map_view.display.height = love.graphics.getHeight() - 10
    player.map_view = map_view
    table.insert(self.map_views, map_view)
  end

  self.runners_view = RunnersView(game_state.runners)
  self.runners_view.display.x = self.display.x
  if #self.compass_views > 0 then
    self.runners_view.display.y = self.compass_views[#self.compass_views].display.y + self.compass_views[#self.compass_views].display.height + 10
  end
  self.runners_view.display.height = love.graphics.getHeight() - self.runners_view.display.y - 20

  self.instructions_view = InstructionsView()

  self.focused_view = nil
end

function GUIMain:setFocus(focus)
  self.focused_view = nil
end

function GUIMain:update(dt, moved)
  if moved and self.focused_view and self.focused_view.reset then
    self.focused_view:reset()
  end
  for i, map_view in pairs(self.map_views) do
    map_view:drawCanvas()
  end
  if self.focused_view and self.focused_view.navigatable then
    if dt_since_last_move + dt > 0.1 then
      if love.keyboard.isDown('+', '-', 'pageup', 'pagedown') then
        dt_since_last_move = 0
      end
      num = false
      if love.keyboard.isDown('+') then
        num = -1
      elseif love.keyboard.isDown('-') then
        num = 1
      elseif love.keyboard.isDown('pageup') then
        num = 5
      elseif love.keyboard.isDown('pagedown') then
        num = -5
      end
      if (num) then
        if love.keyboard.isDown('rshift', 'lshift') then
          num = num * 5
        end
        self.focused_view:moveCursor(num)
      end
    end
  end
end

function GUIMain:draw()
  love.graphics.push()
  for i, view in ipairs(self.compass_views) do
    view:draw()
  end
  love.graphics.push()
  self.runners_view:draw()
  love.graphics.translate(self.display.x, self.display.y)
  love.graphics.pop()
  self:drawMaps()
  love.graphics.pop()
end

function GUIMain:drawMaps()
  for i, map_view in ipairs(self.map_views) do
    map_view.draw_cursor = false
    map_view:draw()
  end
end
