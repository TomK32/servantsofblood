
require('views/list_view')

class "JobsView" (ListView) {

  __init__ = function(self, jobs)
    self.list_entries = jobs
    self.currentLine = 1
    self.display = {x = 420, y = 0, width = 100, height = 300}
  end,

  drawLine = function(self, line_number, job)
    love.graphics.setColor(255,255,255,255)
    love.graphics.print(job.description, 24, 0)
  end
}

