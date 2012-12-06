-- (C) 2012 Thomas R. Koll, <info@ananasblau.com>
-- Cross Country Runner
require("lib/middleclass")
gui = require("lib/quickie")
require('table')
require('entities/runner')
require("player_controller")
require("ai_controller")
require("game_controller")
require("game_state")
require('views/gui_main')
require('worker')
require('worker_spawner')
require('job')
require('job_spawner')
require('views/start_menu_view')

function love.load()
  game_state = GameState()
  gui_main = GUIMain(game_state)
  gui_main.font = love.graphics.newFont(14)
  gui_main.small_font = love.graphics.newFont(10)
  game_controller = GameController(game_state, gui_main)
  dt_since_last_move = 1
  start_menu_view = StartMenuView()
end

function love.update(dt)
  start_menu_view:update()
  local moved = false

  if game_state.paused then
    return
  end
  gui_main:update(dt, moved)
  game_controller:update(dt)
  gui_main:drawMaps()
end

function love.keypressed(key, unicode)
  if not game_state.started then
    return
  end
  dt_since_last_move = 1 -- to allow rapid key hitting
  if unicode >= 49 and unicode < 59 then
    game_state.player:setSpeed(unicode - 48)
  end
  if game_controller.active_controller then
    game_controller.active_controller:keypressed(key, unicode)
  end
end

function love.draw()
  if not game_state.started then
    start_menu_view:draw()
    drawCopyright()
    return
  end
  if game_state.paused then
    -- TODO draw a background
    gui_main.instructions_view:draw()
    drawCopyright()
    return
  end
  love.graphics.clear()
  gui_main:draw()
  love.graphics.setColor(255,255,255,255)
  love.graphics.setFont(gui_main.font)
  if game_state.paused then
    love.graphics.print('PAUSED', 10, 20)
  else
    love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
  end
  drawCopyright()
end

function drawCopyright()
  love.graphics.setFont(gui_main.small_font)
  love.graphics.print(love.graphics.getCaption(), love.graphics.getWidth(), love.graphics.getHeight(), 0, 1, 1, 176, 14)
  love.graphics.setFont(gui_main.font)
end

function finishScreen()
  love.graphics.print('AWESOME, you finished on place ' .. game_state:playerPosition(), love.graphics.getWidth() / 2 - 120, love.graphics.getHeight() / 2 - 5)
  love.graphics.print('Press [q] to quit', love.graphics.getWidth() / 2 - 40, love.graphics.getHeight() / 2 + 25)
end


