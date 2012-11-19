
PlayerController = class("PlayerController")

function PlayerController:initialize(game_state)
  self.speed = 5 -- 5 gets you to the next field, 4 won't yet, 10 is two fields but exhausting
  self.stamina = 100
  self.stamina_dt = 0
  self.stamina_display = 0
  self.regeneration_rate = 1
  self.position = {x = 0, y = 0}
  self.tile_position = 0 -- depending on the speed the player might not yet reach the next field
  self.game_state = game_state
  self.offset = nil
  self.sprint = false
  self.step_dt = 0 -- time needed to cross a field
end


function PlayerController:move(offset, sprint)
  self.offset = offset
  self.sprint = sprint
end

function PlayerController:update(dt)
  if math.abs(self.stamina_display - self.stamina) > 3 then
    self.stamina_display = self.stamina
  end
  if self.stamina_dt > self.regeneration_rate then
    self.stamina = self.stamina + 1
    self.stamina_dt = 0
  end
  self.stamina_dt = self.stamina_dt + (dt * 25)
  if self.stamina > 100 then
    self.stamina = 100
  elseif self.stamina < 1 then
    self.stamina = 1
    return false
  end
  if not self.offset then
    return
  end

  local s = self.speed
  if self.sprint then
    s = 10
    self.stamina = self.stamina - 3
  end
  self.sprint = false

  -- exhausted, go only 1/10th
  if self.stamina <= 10 then
    s = 1
    self.speed = 1
  end

  self.stamina = self.stamina - (s*s / 7)
  self.tile_position = self.tile_position + s 
  if self.tile_position < 10 then
    return
  end

  local old_position = {x = self.position.x, y = self.position.y}
  local offset_factor = 1
  if s > 10 then
    offset_factor = 2
  end
  self.tile_position = self.tile_position % 10

  self.position.x = self.position.x + (self.offset.x * offset_factor)
  self.position.y = self.position.y + (self.offset.y * offset_factor)
  self.game_state.map:fitIntoMap(self.position)

  self.game_state.map:moveEntity(self, old_position, self.position)
  gui_main.map_view:centerAt(self.position)

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
