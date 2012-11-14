
class "ListView" (View) {
  line_height = 20,
  navigatable = true,
  list_entries = nil,
  currentLine = 1,

  moveCursor = function(self, num)
    self.currentLine = self.currentLine + num
    if (self.currentLine < 1) then
      self.currentLine = #self.list_entries
    elseif (self.currentLine > #self.list_entries) then
      self.currentLine = 1
    end
  end,

  drawContent = function(self)
    love.graphics.push()
    local list = {}
    if type(self.listEntries) == 'function' then
      list = self:listEntries()
    else
      list = self.list_entries
    end
    for i, line in pairs(list) do
      love.graphics.translate(0, self.line_height)
      self:drawLine(i, line)
    end
    love.graphics.pop()
    if self.currentLine and #list > 0 then
      love.graphics.translate(0, self.currentLine * self.line_height)
      love.graphics.print('>', 0, 0)
    end
  end
}
