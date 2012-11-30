require('map')

GameState = class("GameState")
GameState:include({
  map = nil,
  player = nil,
  focus = 'inspector', -- main, inspector, jobs
  paused = false,
  runner = nil,
  runners = {},
  start = nil,

  initialize = function(self)
    self.paused = true
    self.jobs = {}
    self.runner = Runner({x=4, y=4}, 'Thomas')
    self.player = PlayerController(self, self.runner)
    self.map = Map(5000,2000)
    self.map:randomize()
    self.map:place(self.runner)
    self.runners = {}
    table.insert(self.runners, self.player)
    self.start = Entities.Waypoint({x = self.player.position.x, y = self.player.position.y}, 'Start')
    local last_waypoint = self.start
    self.map:place(last_waypoint)
    local waypoints = 8
    dt_x = self.map.width / waypoints
    dt_y = self.map.height / waypoints
    local wp = {x = self.player.position.x, y = self.player.position.y}
    for i = 3, waypoints do
      wp = {x = math.floor((i-3) * dt_x + math.random(dt_x * 2)), y = math.floor(i/3 * dt_y + math.random(dt_y * 3))}
      local waypoint = Entities.Waypoint(wp, 'Waypoint ' .. i, false)
      self.map:place(waypoint)
      last_waypoint:setNextWaypoint(waypoint)
      last_waypoint = waypoint
    end
    last_waypoint.is_finish = true
    self.start:setDistanceToFinish()
    self.player.runner.highlight = true
    self.player.next_waypoint = self.start.next_waypoint -- start is on the player's spot

    for i = 1, 199 do
      ai_runner = AIController(self, Runner({x = math.random(3)+2, y = math.random(3)+2}))
      ai_runner.next_waypoint = self.start.next_waypoint
      table.insert(self.runners, ai_runner)
      self.map:place(ai_runner.runner)
    end

  end,
})


function GameState:updateRunningOrder()
  for i, r in pairs(self.runners) do
    r:setDistanceToFinish()
  end
  sort = function(a,b)
    return a.distance_to_finish < b.distance_to_finish
  end
  table.sort(self.runners, sort)
end

function GameState:playerPosition()
  self:updateRunningOrder()
  for i, r in pairs(self.runners) do
    if r == self.player then
      return i
    end
  end
end
