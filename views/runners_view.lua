RunnersView = class("RunnersView", ListView)

function RunnersView:initialize(runners, waypoints)
  self.list_entries = runners
  self.waypoints = waypoints
  self.current_line = false
end
function RunnersView:drawContent()
  love.graphics.setColor(255,255,255,255)
  love.graphics.rectangle('line', 2,2, self.display.width - 6, self.display.height - 6)
  self:drawList()
end
function RunnersView:drawLine(line_number, runner)
  if runner.runner.highlight then
    love.graphics.setColor(255,100, 0, 255)
  else
    love.graphics.setColor(255,255,255,255)
  end
  local txt = (runner.runner.name or 'Runner') .. ' ' .. runner.distance_to_finish
  love.graphics.print(txt, 20, 0)
end
