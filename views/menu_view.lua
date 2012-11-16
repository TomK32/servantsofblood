
MenuView = class("MenuView", ListView)
MenuView:include({
  level = nil, -- main, jobs, other levels
  focus = nil, -- what's the player's focus: a worker, job, workshop
  menu = {
    main = {
      k = 'Inspect',
      j = 'Jobs',
      q = 'Quit'
    }
  },

  initialize = function(self, menu)
    self.display = {x = 0, y = 0}
    self.level = 'main'
    if menu then
      self.menu = menu
    end
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
})
