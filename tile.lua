

class "Tile" {
  entities = {},
  shade = nil,

  __init__ = function(self)
    self.shade = math.random(100)
    self.entities = {}
  end,

  addEntity = function(self,entity)
    table.insert(self.entities, entity)
  end
}

