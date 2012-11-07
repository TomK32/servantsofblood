

class "MapView" {
  map = nil,
  display = {x = 0, y = 0, width = 320, height = 256},
  tile_size = {x = 32, y = 32},

  __init__ = function(self, map)
    self.map = map
  end,

  draw = function(self)
    tiles_x = self.display.width / self.tile_size.x
    tiles_y = self.display.width / self.tile_size.y
    for x = 0, tiles_x do
      for y = 0, tiles_y do
        tile = self.map:get(x+1,y+1)
        if tile then
        print(tile)
          love.graphics.setColor( tile, 0, 0, 255 )
          love.graphics.rectangle('fill', x * self.tile_size.x, y * self.tile_size.y, self.tile_size.x, self.tile_size.y)
        end
      end
    end
  end
}
