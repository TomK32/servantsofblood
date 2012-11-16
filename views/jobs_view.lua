
require('views/list_view')

JobsView = class("JobsView", ListView)
JobsView:include({

  initialize = function(self, jobs)
    self.list_entries = jobs
    self.current_line = 1
  end,

  drawLine = function(self, line_number, job)
    love.graphics.setColor(255,255,255,255)
    love.graphics.print(job:to_s(), 20, 0)
  end
})
