
class "MenuView" {
  display = {x = 430, y = 10, width = 100, height = 200},
  lineHeight = 16,
  level = nil, -- main, jobs, other levels
  focus = nil, -- what's the player's focus: a worker, job, workshop
  menu = {
    main = {
      k = 'inspect'
    }
  },
  __init__ = function(self)
    self.level = 'main'
  end,

  draw = function(self)
    love.graphics.push()
    love.graphics.translate(self.display.x, self.display.y)
    for key, name in pairs(self.menu[self.level]) do
      self:drawAction(key, name)
      love.graphics.translate(0, self.lineHeight)
    end

    love.graphics.pop()
  end,

  drawLevelMain = function(self)
  end,

  drawAction = function(self, key, description)
    love.graphics.setColor(100,255,100,255)
    love.graphics.print(key, 0, 0)
    love.graphics.setColor(255,255,255,255)
    love.graphics.print(description, 20, 0)
  end
}

