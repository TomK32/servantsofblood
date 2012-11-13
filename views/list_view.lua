
class "ListView" (View) {
  line_height = 20,

  drawContent = function(self)
    love.graphics.push()
    for i, line in ipairs(self.list_entries) do
      love.graphics.translate(0, self.line_height)
      self:drawLine(i, line)
    end
    love.graphics.pop()
    love.graphics.translate(0, self.currentLine * self.line_height)
    love.graphics.print('>', 0, 0)
  end
}
