

class "Worker" {
  name = nil,
  currentJob = nil,
  jobs = {},

  __init__ = function(self, name)
    self.name = name
    self.jobs = {}
  end,

  assign = function(self, job)
    if not self.jobs.includes(job) then
      table.insert(self.jobs, job)
    end
 end
}

