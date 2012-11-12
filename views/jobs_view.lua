

class "JobsView" {
  jobs = nil,
  display = {x = 220, y = 0, width = 100, height = 300},
  currentLine = 1,

  __init__ = function(self, jobs)
    self.jobs = jobs
    self.currentLine = 1
    -- TODO: Calculate display
  end,

  moveCursor = function(self, num)
    self.currentLine = self.currentLine + num
    if (self.currentLine < 1) then
      self.currentLine = #self.jobs
    elseif (self.currentLine > #self.jobs) then
      self.currentLine = 1
    end
  end,

  draw = function(self)
    love.graphics.push()
    love.graphics.translate(self.display.x, self.display.y)
    for i, job in ipairs(self.jobs) do
      love.graphics.setColor(255,255,255,255)
      love.graphics.print(job.description, self.display.x+4, self.display.y + (i * 20))
    end
    love.graphics.print('>', self.display.x - 5, self.display.y + (self.currentLine * 20))
    love.graphics.pop()
  end
}

