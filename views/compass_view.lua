
CompassView = class("CompassView", View)

function CompassView:initialize()
  self.display = {x = 0, y = 0, height = 128, width = 128}
end

function CompassView:drawContent()
  if self.player.wrong_direction then
    love.graphics.setColor(255, 0, 0, 255)
  else
    love.graphics.setColor(255, 240, 200, 255)
  end
  love.graphics.rectangle('fill', 10, 10, self.display.width - 10, self.display.height - 20)
  local waypoint = self.player.next_waypoint
  if self.player and waypoint then
    local text = ''
    if self.player.position.y > waypoint.position.y then
      text = text .. 'N'
    elseif self.player.position.y == waypoint.position.y then
    else
      text = text .. 'S'
    end
    if self.player.position.x > waypoint.position.x then
      text = text .. 'W'
    elseif self.player.position.x == waypoint.position.x then
    else
      text = text .. 'E'
    end
    love.graphics.setColor(0,0,0,255)
    love.graphics.print(self.player.position.x .. ':' .. player.position.y, 12, 10)
    love.graphics.print(self.player.next_waypoint.position.x .. ':' .. self.player.next_waypoint.position.y, 12, 25)
    love.graphics.print('Speed: ' .. math.ceil(self.player.speed), self.display.width - 65, 10)
    love.graphics.print('Stamina: ' .. math.ceil(self.player.stamina_display), self.display.width - 85, self.display.height - 10)
    love.graphics.print('Dist: ' .. self.player.distance_to_finish, 12, self.display.height - 32)
    love.graphics.print(text, self.display.width / 2, self.display.height / 2)
  end
end
