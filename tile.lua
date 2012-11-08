

class "Tile" {
  position = {x = 0, y = 0, z = 0},
  entities = {},
  shade = nil,

  __init__ = function(self)
    self.shade = math.random(100)
  end,

  addEntity = function(self,entity)
    table.insert(self.entities, entity)
  end
}

