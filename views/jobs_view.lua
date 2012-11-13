

class "JobsView" (View) {
  jobs = nil,
  currentLine = 1,

  __init__ = function(self, jobs)
    self.jobs = jobs
    self.currentLine = 1
    self.display = {x = 220, y = 0, width = 100, height = 300}
  end,

  moveCursor = function(self, num)
    self.currentLine = self.currentLine + num
    if (self.currentLine < 1) then
      self.currentLine = #self.jobs
    elseif (self.currentLine > #self.jobs) then
      self.currentLine = 1
    end
  end,

  drawContent = function(self)
    for i, job in ipairs(self.jobs) do
      love.graphics.setColor(255,255,255,255)
      love.graphics.print(job.description, self.display.x+4, self.display.y + (i * 20))
    end
    love.graphics.print('>', self.display.x - 5, self.display.y + (self.currentLine * 20))
  end
}

