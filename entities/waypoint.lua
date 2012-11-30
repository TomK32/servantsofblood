
Entities.Waypoint = class("Waypoint", Entities.Base)
Entities.Waypoint.next_waypoint = nil

function Entities.Waypoint:initialize(position, name, is_finish)
  self.position = position
  self.name = name
  self.is_finish = is_finish
  self.distance_to_next = 0
end

function Entities.Waypoint:setNextWaypoint(next_waypoint)
  self.next_waypoint = next_waypoint
  self.distance_to_next = math.sqrt(math.abs(self.position.x - next_waypoint.position.x) ^ 2 + math.abs(self.position.y - next_waypoint.position.y) ^ 2)
end
-- TODO distance

