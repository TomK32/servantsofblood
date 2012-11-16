require('tile')

Map = class("Map")
Map:include({

  initialize = function(self, width, height)
    self.width = width
    self.height = height
    self.map = {}
  end,

  randomize = function(self)
    for y = 1, self.height do
      table.insert(self.map, {})
      --for x = 1, self.width do
        --table.insert(self.map[x], Tile())
      --end
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
      if self.map[position.x][position.y] then
        return self.map[position.x][position.y]
      else
        self.map[position.x][position.y] = Tile()
        return self.map[position.x][position.y]
      end
    end
    return false
  end
})
