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
  gui_main.map_view = MapView(game_state.map)
  game_controller = GameController(game_state, gui_main)
  dt_since_last_move = 1
end

function love.update(dt)
  if game_state.focus == 'jobs' then
    if dt_since_last_move + dt > 0.1 then
      dt_since_last_move = 0
       num = false
      if love.keyboard.isDown('up', 'kp8') then
        num = -1
      elseif love.keyboard.isDown('down', 'kp2') then
        num = 1
      elseif love.keyboard.isDown('pageup') then
        num = 5
      elseif love.keyboard.isDown('pagedown') then
        num = -5
      end
      if (num) then
        if love.keyboard.isDown('rshift', 'lshift') then
          num = num * 5
        end
        gui_main.jobs_view:moveCursor(num)
      end
    end
  elseif game_state.focus == 'inspector' then
    if love.keyboard.isDown('up', 'down','left', 'right', 'kp1', 'kp2', 'kp3', 'kp4', 'kp6', 'kp7', 'kp8', 'kp9') then
      if dt_since_last_move + dt > 0.1 then
        dt_since_last_move = 0
        if love.keyboard.isDown('rshift', 'lshift') then
          moves = 5
        else
          moves = 1
        end
        movements = {
          up    = { y = - moves },
          kp8   = { y = - moves },
          down  = { y =   moves },
          kp2   = { y =   moves },
          left  = { x = - moves },
          kp4   = { x = - moves },
          right = { x =   moves },
          kp6   = { x =   moves },
          kp7   = { x = - moves, y = - moves },
          kp9   = { x =   moves, y = - moves },
          kp1   = { x = - moves, y =   moves },
          kp3   = { x =   moves, y =   moves },
        }
        for key, m in pairs(movements) do
          if love.keyboard.isDown(key) then
            gui_main.map_view:moveCursor(m)
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

  local action = game_controller.control_map.keyboard.on_press[key]
  if action then
    if type(action) == "function" then action(game_controller) end
    if type(game_controller[action]) == 'function' then game_controller[action](game_controller) end
  end
end

function love.draw()
  gui_main:draw()
  love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
end

