-- (C) 2012 Thomas R. Koll, <info@ananasblau.com>
-- Fortress Middle Management Services
require("lib/slither")
require("player_controller")
require("game_state")

function love.load()

end

function love.update(dt)

end

function love.keypressed(key, unicode)

end

function love.draw()
  love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
end

