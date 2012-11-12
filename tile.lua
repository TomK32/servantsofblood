

class "Tile" {
  entities = {},
  shade = nil,

  __init__ = function(self)
    self.shade = math.random(100)
    self.entities = {}
  end,

  addEntity = function(self,entity)
    table.insert(self.entities, entity)
  end,
  jobs = function (self)
    local r = {}
    for i, e in pairs(self.entities) do
      if e.__name__ == 'Job' then
        table.insert(r, e)
      end
    end
    return r
  end
}

