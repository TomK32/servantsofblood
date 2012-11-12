require('map')

class "GameState" {
  map = nil,
  player = nil,
  jobs = nil,
  job_spawner = nil,
  workers = nil,
  worker_spawner = nil,
  focus = 'main',

  __init__ = function(self)
    self.jobs = {}
    self.player = PlayerController()
    self.job_spawner = JobSpawner()
    self.worker_spawner = WorkerSpawner()
    self.map = Map(25,20)
    self.map:randomize()
    self.workers = {}
    for i=1, 3 do
      worker = self.worker_spawner:create()
      table.insert(self.workers, worker)
      self.map:place(worker)
    end
    for i=1, 10 do
      job = self.job_spawner:create()
      job.position = {x = math.random(self.map.width), y = math.random(self.map.height)}
      table.insert(self.jobs, job)
      self.map:place(job)
    end
  end,
}

