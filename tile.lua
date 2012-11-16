require 'entities/base'
require 'entities/ground'
require 'entities/waypoint'

Tile = class("Tile")
Tile:include({
  entities = {},
  shade = nil,

  initialize = function(self)
    self.shade = math.random(100)
    self.entities = {}
    --if math.random() > 0.2 then
    --  table.insert(self.entities, Entities.Ground())
    --end
  end,

  addEntity = function(self,entity)
    table.insert(self.entities, entity)
  end,
  entitiesByType = function (self, klass)
    local r = {}
    for i, e in pairs(self.entities) do
      if klass == e.class or subclassOf(klass, e.class) then
        table.insert(r, e)
      end
    end
    return r
  end,
  jobs = function(self)
    return self:entitiesByType(Job)
  end,
  workers = function(self)
    return self:entitiesByType(Worker)
  end,
  isWaypoint = function(self)
    return #self:entitiesByType(Entities.Waypoint) > 0
  end
})
