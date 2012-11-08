-- (C) 2012 Thomas R. Koll, <info@ananasblau.com>
-- Fortress Middle Management Services
require("lib/slither")
require('table')
require("player_controller")
require("game_state")
require('gui_main')
require('map_view')
require('worker')
require('worker_spawner')
require('job')
require('job_spawner')

function love.load()
  game_state = GameState()
  gui_main = GUIMain(game_state)
  gui_main.map_view = MapView(game_state.map)
end

function love.update(dt)
  if game_state.focus == 'map_view' then
    -- TODO prevent racing cursor
    if love.keyboard.isDown('up', 'k') then
      gui_main.map_view:moveCursor({y = -1})
    elseif love.keyboard.isDown('down', 'j') then
      gui_main.map_view:moveCursor({y = 1})
    elseif love.keyboard.isDown('left', 'h') then
      gui_main.map_view:moveCursor({x = -1})
    elseif love.keyboard.isDown('right', 'l') then
      gui_main.map_view:moveCursor({x = 1})
    end
  end
  game_state:update()
end

function love.keypressed(key, unicode)
 end

function love.draw()
  gui_main:draw()
  love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
end

