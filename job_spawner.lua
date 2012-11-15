require('jobs/dig')

class "JobSpawner" {

  jobs = {
    Dig

  },

  __init__ = function(self)
  end,

  create = function(self)
    local tmp = self.jobs[math.random(1, #self.jobs)]
    return tmp()
  end
}
