require 'entities/ground'

class "Tile" {
  entities = {},
  shade = nil,

  __init__ = function(self)
    self.shade = math.random(100)
    self.entities = {}
    if math.random() > 0.2 then
      table.insert(self.entities, Ground())
    end
  end,

  addEntity = function(self,entity)
    table.insert(self.entities, entity)
  end,
  entitiesByType = function (self, t)
    local r = {}
    for i, e in pairs(self.entities) do
      if e.__name__ == t then
        table.insert(r, e)
      end
    end
    return r
  end,
  jobs = function(self)
    return self:entitiesByType('Job')
  end,
  workers = function(self)
    return self:entitiesByType('Worker')
  end
}

