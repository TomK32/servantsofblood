require('map')

GameState = class("GameState")
GameState:include({
  map = nil,
  focus = 'inspector', -- main, inspector, jobs
  started = false,
  paused = false,
  runners = {},
  start = nil,
  players = {}
 })

function GameState:initialize()
  self.map = Map(5000,2000)
  self.map:randomize()
end

function GameState:start()
  self.paused = true
  self.started = true
  self.runners = {}
  self.start = Entities.Waypoint({x = 5, y = 5}, 'Start')
  local last_waypoint = self.start
  self.map:place(last_waypoint)
  local waypoints = 8
  dt_x = self.map.width / waypoints
  dt_y = self.map.height / waypoints
  local wp = {x = 5, y = 5}
  for i = 3, waypoints do
    wp = {x = math.floor((i-3) * dt_x + math.random(dt_x * 2)), y = math.floor(i/3 * dt_y + math.random(dt_y * 3))}
    local waypoint = Entities.Waypoint(wp, 'Waypoint ' .. i, false)
    self.map:place(waypoint)
    last_waypoint:setNextWaypoint(waypoint)
    last_waypoint = waypoint
  end
  last_waypoint.is_finish = true
  self.start:setDistanceToFinish()

  for i = 1, 199 do
    ai_runner = AIController(self, Runner({x = math.random(3)+2, y = math.random(3)+2}))
    ai_runner.next_waypoint = self.start.next_waypoint
    table.insert(self.runners, ai_runner)
    self.map:place(ai_runner.runner)
  end

end


function GameState:addPlayer(name)
  runner = Runner({x=4, y=4}, name, true)
  player = PlayerController(self, runner, (#self.players + 1))
  player.next_waypoint = self.start.next_waypoint -- start is on the player's spot
  self.map:place(runner)
  table.insert(self.players, player)
end

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
