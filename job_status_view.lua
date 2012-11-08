

class "JobStatusView" {
  jobs = nil,
  display = {x = 430, y = 0, width = 100, height = 300},

  __init__ = function(self, jobs)
    self.jobs = jobs
    -- TODO: Calculate display
  end,

  draw = function(self)
    for i, job in ipairs(self.jobs) do
      love.graphics.setColor(255,255,255,255)
      love.graphics.print(job.description, self.display.x, self.display.y + (i * 20))
    end
  end
}
