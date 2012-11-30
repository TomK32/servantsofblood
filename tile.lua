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

  addEntity = function(self, entity)
    if not self.entities[entity.class] then
      self.entities[entity.class] = {}
    end
    table.insert(self.entities[entity.class], entity)
  end,
  removeEntity = function(self, entity)
    for i, e in pairs(self.entities[entity.class]) do
      if e == entity then
        table.remove(self.entities[entity.class], i)
        return true
      end
    end
    return false
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
  runners = function(self)
    return (self.entities[Runner] or {})
  end,
  isWaypoint = function(self)
    return self.entities.Waypoint and #self.entities.Waypoint > 0
  end
})
