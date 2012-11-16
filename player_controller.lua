
PlayerController = class("PlayerController")

function PlayerController:initialize(game_state)
  self.speed = 5 -- 5 gets you to the next field, 4 won't yet, 10 is two fields but exhausting
  self.stamina = 100
  self.position = {x = 0, y = 0}
  self.tile_position = 0 -- depending on the speed the player might not yet reach the next field
  self.game_state = game_state
  self.offset = {}
  self.sprint = false
end


function PlayerController:move(offset, sprint)
  self.offset = offset
  self.sprint = sprint
end

function PlayerController:update(dt)
  self.stamina = self.stamina + 1

  local s = self.speed
  -- FIXME sprint doesn't work yet
  if self.sprint then
    s = 10
    self.stamina = self.stamina - 3
  end
  self.sprint = false

  -- exhausted, go only 1/10th
  if self.stamina <= 10 then
    self.tile_position = self.tile_position + 1
    return
  elseif self.stamina > 100 then
    self.stamina = 100
  end
  if not self.offset then
    return
  end
  self.stamina = self.stamina - s
  self.tile_position = self.tile_position + s * dt
  if self.tile_position >= 10 and self.stamina > 10 then
    gui_main.map_view:moveCursor({x = self.offset.x * 2, y = self.offset.y * 2})
    self.tile_position = self.tile_position % 10
  elseif self.tile_position > 5 then
    self.tile_position = self.tile_position - 5
    gui_main.map_view:moveCursor(self.offset)
  else
    return
  end
  self.offset = nil

  if self.next_waypoint and
      self.position.x == self.next_waypoint.position.x and
      self.position.y == self.next_waypoint.position.y then
    if self.next_waypoint.is_finish then
      self.game_state.paused = true
      self.game_state.ended = true
      love.draw = self.finishScreen
    else
      self.next_waypoint = self.next_waypoint.next_waypoint
    end
  end
end

function PlayerController:setSpeed(speed)
  if speed < 1 or speed > 10 then
    return false
  end
  self.speed = speed
end

function PlayerController.finishScreen()
  love.graphics.print('AWESOME, you reached your target', love.graphics.getWidth() / 2 - 120, love.graphics.getHeight() / 2 - 5)
  love.graphics.print('Press [q] to quit', love.graphics.getWidth() / 2 - 40, love.graphics.getHeight() / 2 + 25)
end
