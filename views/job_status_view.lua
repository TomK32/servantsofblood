

class "JobStatusView" {
  display = {x = 220, y = 0, width = 100, height = 300},

  __init__ = function(self)
  end,

  draw = function(self, job)
    love.graphics.push()
    love.graphics.translate(self.display.x, self.display.y)
    -- TODO
    love.graphics.pop()
  end
}
