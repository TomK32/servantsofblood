
require('views/list_view')

class "JobsView" (ListView) {

  __init__ = function(self, jobs)
    self.list_entries = jobs
    self.currentLine = 1
  end,

  drawLine = function(self, line_number, job)
    love.graphics.setColor(255,255,255,255)
    love.graphics.print(job.description, 20, 0)
  end
}

