
Entities.Waypoint = class("Waypoint", Entities.Base)
Entities.Waypoint.next_waypoint = nil

function Entities.Waypoint:initialize(position, name, is_finish)
  self.position = position
  self.name = name
  self.is_finish = is_finish
end

-- TODO distance

