
class "JobSpawner" {

  jobs = {
    {name = "Haul", category = "Labor"},
    {name = "Dig", category = "Mining"},
    {name = "Extract metal", category = "Mining"}
  },

  __init__ = function(self)
  end,

  create = function(self)
    local tmp = self.jobs[math.random(1, #self.jobs)]
    return Job(tmp.name, tmp.category)
  end
}
