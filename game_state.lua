require('map')

class "GameState" {
  map = nil,
  player = nil,
  jobs = nil,
  job_spawner = nil,

  __init__ = function(self)
    self.jobs = {}
    self.player = PlayerController()
    self.job_spawner = JobSpawner()
    self.map = Map(30,30)
    self.map:randomize()
  end,

  update = function(self)
    if #self.jobs < 10 and math.random(4) > 2 then
      table.insert(self.jobs, self.job_spawner:create())
    end
  end
}

