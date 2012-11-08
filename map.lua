require('tile')

class "Map" {
  width = 0,
  height = 0,
  map = {},

  __init__ = function(self, width, height)
    self.width = width
    self.height = height
    self.map = {}
  end,

  randomize = function(self)
    for x = 1, self.width do
      table.insert(self.map, {})
      for y = 1, self.height do
        table.insert(self.map[x], Tile())
      end
    end
  end,

  place = function(self, entity)
    tile = self:getTile(entity.position)
    if tile then
      tile:addEntity(entity)
    end
  end,

  getTile = function(self, position)
    if self.map[position.x] then
      if self.map[position.y] then
        return self.map[position.x][position.y]
      end
    end
    return false
  end
}
