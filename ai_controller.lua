AIController = class("AIController", PlayerController)
function AIController:update(dt)
  if not self.direction and self.stamina_dt > self.regeneration_rate and self.runner.next_waypoint  and math.random(100) > 80 then
    x = self.runner.next_waypoint.position.x - self.position.x
    y = self.runner.next_waypoint.position.y - self.position.y
    if x >= 0 then x = 1 end
    if x < 0 then x = -1 end
    if y >= 0 then y = 1 end
    if y < 0 then y = -1 end
    self.direction = {x = x, y = y}
    self.speed = math.random(10)
  end
  self:updatePosition(dt)
end

