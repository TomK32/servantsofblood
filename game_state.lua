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
    self.player = PlayerController(self)
    self.player.position = {x = 4, y = 4}
    self.job_spawner = JobSpawner()
    self.worker_spawner = WorkerSpawner()
    self.map = Map(5000,500)
    self.map:randomize()
    self.workers = {}
    for i=1, 3 do
      worker = self.worker_spawner:create()
      table.insert(self.workers, worker)
      self.map:place(worker)
    end

    local last_waypoint = Entities.Waypoint({x = self.player.position.x, y = self.player.position.y}, 'Start')
    self.player.next_waypoint = last_waypoint
    self.map:place(last_waypoint)
    dt_x = self.map.width / 50
    dt_y = self.map.height / 50
    local wp = {x = self.player.position.x, y = self.player.position.y}
    for i = 1, 10 do
      wp = {x = wp.x + math.random(dt_x) + i, y = wp.y + math.random(dt_y) + i}
      local waypoint = Entities.Waypoint(wp, 'Waypoint ' .. i, false)
      self.map:place(waypoint)
      last_waypoint.next_waypoint = waypoint
      last_waypoint = waypoint
    end
    last_waypoint.is_finish = true
  end,
})
