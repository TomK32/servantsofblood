
class "View" {
  display = {x = 0, y = 0, width = 100, height = 100},
  focus = nil,

  draw = function(self)
    love.graphics.push()
    love.graphics.translate(self.display.x, self.display.y)
    self:drawContent()
    love.graphics.pop()
  end
}
