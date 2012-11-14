
class "InspectorView" (ListView) {
  cursor_row = 1,
  entities = nil,

  __init__ = function(self)
    self.cursor_row = 1
    self.entities = {}
  end,

  drawLine = function(self, line_number, entity)
    love.graphics.setColor(255,255,255,255)
    if entity.__name__ == 'Job' then
      text = entity.description
    elseif entity.__name__ == 'Worker' then
      text = entity.name
    end
    if text then
      love.graphics.print(text, 24, 0)
    end
  end
}
