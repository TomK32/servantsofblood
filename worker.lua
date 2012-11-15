

Worker = class("Worker")
Worker:include({
  name = nil,
  currentJob = nil,
  jobs = {},
  position = {x = 1, y = 1, z = 1},

  initialize = function(self, name, position)
    self.name = name
    self.jobs = {}
    self.position = position
  end,

  assign = function(self, job)
    if not self.jobs.includes(job) then
      table.insert(self.jobs, job)
    end
  end,

  to_s = function(self)
    return self.name
  end,

  description = function(self)
    return self.name .. ' has ' .. #self.jobs .. ' jobs'
  end
})
