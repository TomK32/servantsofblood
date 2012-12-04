-- (C) 2012 Thomas R. Koll, <info@ananasblau.com>
-- Cross Country Runner
require("lib/middleclass")
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

function love.load()
  game_state = GameState()
  gui_main = GUIMain(game_state)
  gui_main.font = love.graphics.newFont(14)
  gui_main.small_font = love.graphics.newFont(10)
  game_controller = GameController(game_state, gui_main)
  dt_since_last_move = 1
end
function love.update(dt)
  local moved = false
  if game_state.focus == 'inspector' or game_state.focus == 'main' then
    if love.keyboard.isDown('up', 'down','left', 'right', 'kp1', 'kp2', 'kp3', 'kp4', 'kp6', 'kp7', 'kp8', 'kp9') then
      -- FIXME move into playerController
      if dt_since_last_move > 0.1 then
        moves = 1
        movements = {
          up    = { x = 0, y = - moves },
          kp8   = { x = 0, y = - moves },
          down  = { x = 0, y =   moves },
          kp2   = { x = 0, y =   moves },
          left  = { x = - moves, y = 0 },
          kp4   = { x = - moves, y = 0 },
          right = { x =   moves, y = 0 },
          kp6   = { x =   moves, y = 0 },
          kp7   = { x = - moves, y = - moves },
          kp9   = { x =   moves, y = - moves },
          kp1   = { x = - moves, y =   moves },
          kp3   = { x =   moves, y =   moves },
        }
        movement = {x = 0, y = 0}
        for key, m in pairs(movements) do
          if love.keyboard.isDown(key) then
            dt_since_last_move = 0
            moved = true
            movement.x = movement.x + m.x
            movement.y = movement.y + m.y
          end
        end
        game_state.player:move(movement, love.keyboard.isDown('rshift', 'lshift'))
      end
    end
    dt_since_last_move = dt_since_last_move + dt
  end

  if game_state.paused then
    return
  end
  gui_main:update(dt, moved)
  game_controller:update(dt)
  gui_main.map_view:drawCanvas()
end

function love.keypressed(key, unicode)
  dt_since_last_move = 1 -- to allow rapid key hitting
  if unicode >= 49 and unicode < 59 then
    game_state.player:setSpeed(unicode - 48)
  end
  if game_controller.active_controller then
    game_controller.active_controller:keypressed(key, unicode)
  end
end

function love.draw()
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


