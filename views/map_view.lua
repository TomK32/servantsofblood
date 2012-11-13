

class "MapView" (View) {
  map = nil,
  tile_size = {x = 16, y = 16},
  cursor_position = { x = 14, y = 11 },
  draw_cursor = false,

  __init__ = function(self, map)
    self.map = map
    self.display = {x = 0, y = 0, width = 400, height = 320}
    self.draw_cursor = false
  end,

  currentTile = function(self)
    return self.map:getTile(self.cursor_position)
  end,

  drawContent = function(self)
    tiles_x = self.display.width / self.tile_size.x
    tiles_y = self.display.height / self.tile_size.y
    for x =1, tiles_x do
      for y = 1, tiles_y do
        tile = self.map:getTile({x = x, y = y})
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
      love.graphics.print('X', self.cursor_position.x * self.tile_size.x, self.cursor_position.y * self.tile_size.y)

      -- print cursor position
      love.graphics.print(self.cursor_position.x .. ':' .. self.cursor_position.y, self.tile_size.x+2, self.display.height)
    end
  end,

  moveCursor = function(self, offset)
    if offset.x then
      self.cursor_position.x = self.cursor_position.x + offset.x
    end
    if offset.y then
      self.cursor_position.y = self.cursor_position.y + offset.y
    end
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
  end
}
