
require('views/list_view')

class "JobsView" (ListView) {
  list_entries = nil,
  currentLine = 1,

  __init__ = function(self, jobs)
    self.list_entries = jobs
    self.currentLine = 1
    self.display = {x = 420, y = 0, width = 100, height = 300}
  end,

  moveCursor = function(self, num)
    self.currentLine = self.currentLine + num
    if (self.currentLine < 1) then
      self.currentLine = #self.list_entries
    elseif (self.currentLine > #self.list_entries) then
      self.currentLine = 1
    end
  end,

  drawLine = function(self, line_number, job)
    love.graphics.setColor(255,255,255,255)
    love.graphics.print(job.description, 24, 0)
  end
}

