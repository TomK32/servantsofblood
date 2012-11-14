-- (C) 2012 Thomas R. Koll, <info@ananasblau.com>
-- Fortress Middle Management Services
require("lib/slither")
require('table')
require("player_controller")
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
  game_controller = GameController(game_state, gui_main)
  dt_since_last_move = 1
end

function love.update(dt)
  if game_state.running == false then
    return
  end
  gui_main:update(dt)
  if game_state.focus == 'inspector' or game_state.focus == 'main' then
    if love.keyboard.isDown('up', 'down','left', 'right', 'kp1', 'kp2', 'kp3', 'kp4', 'kp6', 'kp7', 'kp8', 'kp9') then
      if dt_since_last_move + dt > 0.1 then
        if love.keyboard.isDown('rshift', 'lshift') then
          moves = 5
        else
          moves = 1
        end
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
        for key, m in pairs(movements) do
          if love.keyboard.isDown(key) then
            dt_since_last_move = 0
            if game_state.focus == 'inspector' then
              gui_main.map_view:moveCursor(m)
            elseif game_state.focus == 'main' then
              gui_main.map_view:moveTopLeft(m)
            end
          end
        end
      else
        dt_since_last_move = dt_since_last_move + dt
      end
    end
 end
  game_controller:update()
end

function love.keypressed(key, unicode)
  dt_since_last_move = 1 -- to allow rapid key hitting
  if game_controller.active_controller then
    game_controller.active_controller:keypressed(key, unicode)
  end
end

function love.draw()
  gui_main:draw()
  love.graphics.setColor(255,255,255,255)
  love.graphics.setFont(love.graphics.newFont(14))
  if game_state.running then
    love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
  else
    love.graphics.print('PAUSED', 10, 20)
  end
end

