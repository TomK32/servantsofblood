require('map')

GameState = class("GameState")
GameState:include({
  map = nil,
  player = nil,
  jobs = nil,
  job_spawner = nil,
  workers = nil,
  worker_spawner = nil,
  focus = 'inspector', -- main, inspector, jobs
  paused = false,
  

  initialize = function(self)
    self.paused = true
    self.jobs = {}
    self.player = PlayerController()
    self.player.position = {x = 4, y = 4}
    self.job_spawner = JobSpawner()
    self.worker_spawner = WorkerSpawner()
    self.map = Map(50,50)
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
    self.map:place(Entities.Start(self.player.position.x, self.player.position.y))
  end,
})
