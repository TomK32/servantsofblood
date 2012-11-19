
CompassView = class("CompassView", View)

CompassView.display = {x = 0, y = 0, height = 128, width = 128}

function CompassView:drawContent(player)
  love.graphics.setColor(255, 240, 200, 255)
  love.graphics.rectangle('fill', 10, 10, self.display.width, self.display.height)
  local waypoint = player.next_waypoint
  if player and waypoint then
    local text = ''
    if player.position.y > waypoint.position.y then
      text = text .. 'N'
    elseif player.position.y == waypoint.position.y then
    else
      text = text .. 'S'
    end
    if player.position.x > waypoint.position.x then
      text = text .. 'W'
    elseif player.position.x == waypoint.position.x then
    else
      text = text .. 'E'
    end
    love.graphics.setColor(0,0,0,255)
    love.graphics.print(player.position.x .. ':' .. player.position.y, 10, 10)
    love.graphics.print('Speed: ' .. math.ceil(player.speed), self.display.height - 65, 10)
    love.graphics.print('Stamina: ' .. math.ceil(player.stamina_display), self.display.height - 85, self.display.height - 10)
    love.graphics.print(text, self.display.width / 2, self.display.height / 2)
  end
end
