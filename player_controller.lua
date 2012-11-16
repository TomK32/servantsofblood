
PlayerController = class("PlayerController")

function PlayerController:initialize(game_state)
  self.position = {x = 0, y = 0}
  self.game_state = game_state
end

function PlayerController:move(offset)
  gui_main.map_view:moveCursor(offset)
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
function PlayerController.finishScreen()
  love.graphics.print('AWESOME, you reached your target', love.graphics.getWidth() / 2 - 120, love.graphics.getHeight() / 2 - 5)
  love.graphics.print('Press [q] to quit', love.graphics.getWidth() / 2 - 40, love.graphics.getHeight() / 2 + 25)
end
