
InstructionsView = class("InstructionsView", View)
function InstructionsView:initialize()
  self:setDisplay({align = {x = 'center', y = 'center'}, width = 400, height = 100})
end

function InstructionsView:drawContent()
  love.graphics.setColor(00,0,0,220)
  love.graphics.rectangle('fill', 0, 0, self.display.width, self.display.height)
  love.graphics.setColor(200,200,200,255)
  love.graphics.rectangle('line', 0, 0, self.display.width, self.display.height)

  love.graphics.print('Use your arrows keep to move around', 20, 10)
  love.graphics.print('Hit space to pause the game', 20, 25)
  love.graphics.print('Hit q to quit the game', 20, 40)
  love.graphics.setColor(255,255,255,255)
  love.graphics.print('Follow the waypoints to the finish', 20, 80)
end
