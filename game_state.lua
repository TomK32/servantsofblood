require('map')

class "GameState" {
  map = nil,
  player = nil,
  jobs = nil,
  job_spawner = nil,
  workers = nil,
  worker_spawner = nil,
  focus = 'map_view',

  __init__ = function(self)
    self.jobs = {}
    self.player = PlayerController()
    self.job_spawner = JobSpawner()
    self.worker_spawner = WorkerSpawner()
    self.map = Map(25,20)
    self.map:randomize()
    self.workers = {}
    for i=0, 5 do
      worker = self.worker_spawner:create()
      table.insert(self.workers, worker)
      self.map:place(worker)
    end
   end,

  update = function(self)
    if #self.jobs < 10 and math.random(4) > 2 then
      table.insert(self.jobs, self.job_spawner:create())
    end
  end
}

