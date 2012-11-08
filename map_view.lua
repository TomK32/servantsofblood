

class "MapView" {
  map = nil,
  display = {x = 0, y = 0, width = 400, height = 320},
  tile_size = {x = 16, y = 16},
  cursor_position = { x = 16, y = 16 },

  __init__ = function(self, map)
    self.map = map
  end,

  draw = function(self)
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
            love.graphics.print( 'J', x * self.tile_size.x+4, y * self.tile_size.y)
          end
        end
      end
    end

    -- print cursor
    love.graphics.setColor(255,255,255,255)
    love.graphics.setFont(love.graphics.newFont(self.tile_size.x-4))
    love.graphics.print('X', self.cursor_position.x * self.tile_size.x, self.cursor_position.y * self.tile_size.y)

    -- print cursor position
    love.graphics.print(self.cursor_position.x .. ':' .. self.cursor_position.y, self.tile_size.x+2, self.display.height)
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
