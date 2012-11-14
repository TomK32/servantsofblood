

class "MapView" (View) {
  map = nil,
  tile_size = {x = 16, y = 16},
  cursor_position = { x = 14, y = 11 },
  top_left = { x = 0, y = 0 }, -- offset
  draw_cursor = false,

  __init__ = function(self, map)
    self.map = map
    self.display = {x = 0, y = 0, width = 100, height = 320}
    self.draw_cursor = false
  end,

  currentTile = function(self)
    return self.map:getTile(self.cursor_position)
  end,

  drawContent = function(self)
    tiles_x = (self.display.width / self.tile_size.x) - 1
    tiles_y = (self.display.height / self.tile_size.y) - 1
    for x = 1, tiles_x do
      for y = 1, tiles_y do
        tile = self.map:getTile({x = self.top_left.x + x, y = self.top_left.y + y})
        if tile then
          love.graphics.setColor( tile.shade, 0, 0, 255 )
          love.graphics.rectangle('fill', x * self.tile_size.x, y * self.tile_size.y, self.tile_size.x, self.tile_size.y)
          if #tile.entities > 0 then
            love.graphics.setColor(200,200,200,255)
            if tile.entities[1].__name__ == 'Worker' then
              love.graphics.print( ':)', x * self.tile_size.x+4, y * self.tile_size.y)
            elseif #tile:jobs() > 0 then
              love.graphics.print( '%', x * self.tile_size.x+2, y * self.tile_size.y)
            end
          end
        end
      end
    end
    if self.draw_cursor then
      -- print cursor
      love.graphics.setColor(255,255,255,255)
      love.graphics.print('X', (self.cursor_position.x - self.top_left.x) * self.tile_size.x,
          (self.cursor_position.y - self.top_left.y) * self.tile_size.y)

      -- print cursor position
      love.graphics.print(self.cursor_position.x .. ':' .. self.cursor_position.y, self.tile_size.x+2, self.display.height - 10)
    end
  end,

  tiles_x = function(self)
    return math.floor(self.display.width / self.tile_size.x)
  end,

  tiles_y = function(self)
    return math.floor(self.display.height / self.tile_size.y)
  end,

  moveTopLeft = function(self, offset, dontMoveCursor)
    self.top_left.x = self.top_left.x + 3 * offset.x
    self.top_left.y = self.top_left.y + 3 * offset.y
    max_x = math.floor(self.map.height - self:tiles_x())
    if self.top_left.x < 0 then
      self.top_left.x = 0
    elseif self.top_left.x > max_x then
      self.top_left.x = max_x + 1
    end
    max_y = math.floor(self.map.height - self:tiles_y())
    if self.top_left.y < 0 then
      self.top_left.y = 0
    elseif self.top_left.y > max_y then
      self.top_left.y = max_y + 1
    end
    if not dontMoveCursor then
      self:moveCursor({x = offset.x * 3, y = offset.y * 3}, true)
    end
  end,

  moveCursor = function(self, offset, dontMoveTopLeft)
    self.cursor_position.x = self.cursor_position.x + offset.x
    self.cursor_position.y = self.cursor_position.y + offset.y
    if self.cursor_position.x < 1 then
      self.cursor_position.x = 1
    elseif self.cursor_position.x > self.map.width then
      self.cursor_position.x = self.map.width
    end
    if self.cursor_position.y < 1 then
      self.cursor_position.y = 1
    elseif self.cursor_position.y > self.map.height then
      self.cursor_position.y = self.map.height
    end
    if not dontMoveTopLeft then
      if self.cursor_position.x - 3 < self.top_left.x then
        self:moveTopLeft({x = - 1, y = 0}, true)
      elseif self.cursor_position.x + 3 > self.top_left.x + self:tiles_x() then
        self:moveTopLeft({x = 1, y = 0}, true)
      end
      if self.cursor_position.y - 3 < self.top_left.y then
        self:moveTopLeft({x = 0, y = - 1}, true)
      elseif self.cursor_position.y + 3 > self.top_left.y + self:tiles_y() then
        self:moveTopLeft({x = 0, y = 1}, true)
      end
    end
  end
}
