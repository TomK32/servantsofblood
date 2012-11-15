
class "InspectorView" (ListView) {
  cursor_row = 1,
  entities = nil,
  details = false,

  __init__ = function(self)
    self.cursor_row = 1
    self.entities = {}
    self.details = false
  end,

  drawContent = function(self)
    self:drawList()
    if self.details then
      local entry = self:currentEntry()
      if entry then
        love.graphics.print(self:currentEntry():to_s(), 0,  140)
      else
        self.details = false
      end
    end
  end,

  drawLine = function(self, line_number, entity)
    love.graphics.setColor(255,255,255,255)
    if entity.to_s and entity:to_s() then
      love.graphics.print(entity:to_s(), 20, 0)
    end
  end
}
