-- (C) 2012 Thomas R. Koll, <info@ananasblau.com>
-- Fortress Middle Management Services
require("lib/slither")
require('table')
require("player_controller")
require("game_state")
require('map_view')
require('worker')
require('job')

function love.load()
  game_state = GameState()
  map_view = MapView(game_state.map)
end

function love.update(dt)

end

function love.keypressed(key, unicode)

end

function love.draw()
  map_view:draw()
  love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
end

