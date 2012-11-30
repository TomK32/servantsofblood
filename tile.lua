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
    if not self.entities[entity.class.name] then
      self.entities[entity.class.name] = {}
    end
    table.insert(self.entities[entity.class.name], entity)
  end,
  removeEntity = function(self, entity)
    for i, e in pairs(self.entities[entity.class.name]) do
      if e == entity then
        table.remove(self.entities[entity.class.name], i)
        return true
      end
    end
    return false
  end,
  runners = function(self)
    return (self.entities['Runner'] or {})
  end,
  runnerHighlight = function(self)
    if not self.entities['Runner'] or # self.entities['Runner'] == 0 then
      return false
    end
    for i, runner in pairs(self.entities['Runner']) do
      if runner.highlight then
        return true
      end
    end
  end,
  isWaypoint = function(self)
    return self.entities["Waypoint"] and #self.entities["Waypoint"] > 0
  end
})
