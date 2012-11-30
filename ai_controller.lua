AIController = class("AIController", PlayerController)
function AIController:update(dt)
  if not self.runner.running then return end
  if not self.direction and self.stamina_dt > self.regeneration_rate and self.next_waypoint and math.random(100) > 80 then
    x = self.next_waypoint.position.x - self.position.x
    y = self.next_waypoint.position.y - self.position.y
    if x >= 2 then x = math.random(2) end
    if x < -1 then x = -1 * math.random(2) end
    if y >= 2 then y = math.random(2) end
    if y < -1 then y = -1 * math.random(2) end
    self.direction = {x = x, y = y}
    self.speed = math.random(10)
  end
  self:updatePosition(dt)
end

function AIController:finishReached()
  self.runner.running = false
end


