

class "Map" {
  width = 0,
  height = 0,
  map = {},

  __init__ = function(self, width, height)
    self.width = width
    self.height = height
    self.map = {}
  end,

  get = function(self, x, y)
    if x == nil or y == nil then
      return nil
    end
    return self.map[x][y]
  end,
 
  randomize = function(self)
    for x = 0, self.width do
      table.insert(self.map, {})
      for y = 0, self.height do
        table.insert(self.map[x+1], math.random(63,90))
      end
    end
  end
}
