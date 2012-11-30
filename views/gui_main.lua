
require('views/view')
require('views/list_view')
require('views/map_view')
require('views/compass_view')
require('views/runners_view')

GUIMain = class("GUIMain")
GUIMain:include({

  initialize = function(self, game_state)
    self.game_state = game_state

    self.display = {x = love.graphics.getWidth() - ListView.display.width, y = 148}

    -- compass on top, any other info view below that
    self.compass_view = CompassView()
    self.compass_view.display.x = self.display.x

    self.runners_view = RunnersView(game_state.runners)
    self.runners_view.display.x = self.display.x
    self.runners_view.display.y = self.compass_view.display.y + self.compass_view.display.height + 10
    self.runners_view.display.height = love.graphics.getHeight() - self.runners_view.display.y - 20

    self.map_view = MapView(game_state.map)
    self.map_view.display.width = self.display.x - 10
    self.map_view.display.height = love.graphics.getHeight() - 10
    self.map_view:drawCanvas()

    self.focused_view = nil
  end,

  setFocus = function(self, focus)
    self.focused_view = nil
  end,

  update = function(self, dt, moved)
    if moved and self.focused_view and self.focused_view.reset then
      self.focused_view:reset()
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
  end,

  draw = function(self)
    love.graphics.push()
    self.compass_view:draw(self.game_state.player)
    love.graphics.push()
    self.runners_view:draw()
    love.graphics.translate(self.display.x, self.display.y)
    self.map_view.draw_cursor = false
    love.graphics.pop()
    self.map_view:draw()
    love.graphics.pop()
  end
})
