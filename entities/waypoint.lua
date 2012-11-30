
Entities.Waypoint = class("Waypoint", Entities.Base)
Entities.Waypoint.next_waypoint = nil

function Entities.Waypoint:initialize(position, name, is_finish)
  self.position = position
  self.name = name
  self.is_finish = is_finish
  self.distance_to_next = 0
  self.distance_to_finish = 0
end

function Entities.Waypoint:setNextWaypoint(next_waypoint)
  self.next_waypoint = next_waypoint
  self.distance_to_next = self:distanceTo(next_waypoint.position)
end

function Entities.Waypoint:distanceTo(position)
  return math.sqrt(math.abs(self.position.x - position.x) ^ 2 + math.abs(self.position.y - position.y) ^ 2)
end

function Entities.Waypoint:setDistanceToFinish()
  if self.is_finish then
    return 0
  end
  self.distance_to_finish = math.floor(self.distance_to_next + self.next_waypoint:setDistanceToFinish())
  return self.distance_to_finish
end
-- TODO distance

