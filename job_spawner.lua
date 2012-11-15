require('jobs/dig')

JobSpawner = class("JobSpawner")
JobSpawner:include({

  jobs = {
    Dig

  },

  initialize = function(self)
  end,

  create = function(self)
    local tmp = self.jobs[math.random(1, #self.jobs)]
    return tmp()
  end
})
