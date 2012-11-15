
class "MenuView" (ListView) {
  lineHeight = 16,
  level = nil, -- main, jobs, other levels
  focus = nil, -- what's the player's focus: a worker, job, workshop

  menu = {
    main = {
      k = 'Inspect',
      j = 'Jobs',
      q = 'Quit'
    }
  },
  __init__ = function(self, menu)
    self.level = 'main'
    if menu then
      self.menu = menu
    end
    self.display = {x = 0, y = 0, height = 200, width = 200 }
  end,

  setLevel = function(self, level)
    if self.menu[level] then
      self.level = level
      return true
    else
      return false
    end
  end,

  listEntries = function(self)
    return self.menu[self.level]
  end,

  drawLine = function(self, key, description)
    love.graphics.setColor(100,255,100,255)
    love.graphics.print(key, 0, 0)
    love.graphics.setColor(255,255,255,255)
    love.graphics.print(description, 20, 0)
  end
}

