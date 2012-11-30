require('map')

GameState = class("GameState")
GameState:include({
  map = nil,
  player = nil,
  focus = 'inspector', -- main, inspector, jobs
  paused = false,
  runner = nil,

  initialize = function(self)
    self.paused = true
    self.jobs = {}
    self.runner = Runner()
    self.player = PlayerController(self, self.runner)
    self.map = Map(5000,2000)
    self.map:randomize()
    self.map:place(self.runner)

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
    self.player.next_waypoint = self.player.next_waypoint.next_waypoint -- start is on the player's spot
    last_waypoint.is_finish = true
  end,
})
