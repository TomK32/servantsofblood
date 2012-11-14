
class "MenuView" (ListView) {
  lineHeight = 16,
  level = nil, -- main, jobs, other levels
  focus = nil, -- what's the player's focus: a worker, job, workshop
  menu = {
    main = {
      k = 'Inspect',
      j = 'Jobs'
    }
  },
  __init__ = function(self)
    self.display = {x = 430, y = 10, width = 100, height = 200}
    self.level = 'main'
  end,

  listEntries = function(self)
    print(pairs(self.menu.main))
    return self.menu.main
  end,

  drawLine = function(self, key, description)
    love.graphics.setColor(100,255,100,255)
    love.graphics.print(key, 0, 0)
    love.graphics.setColor(255,255,255,255)
    love.graphics.print(description, 20, 0)
  end
}

