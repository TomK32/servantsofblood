
class "InspectorView" {
  display = {x = 220, y = 0, width = 100, height = 300},
  cursor_row = 1,

  __init__ = function(self)
    self.cursor_row = 1
  end,

  draw = function(self, entities)
    love.graphics.push()
    love.graphics.translate(self.display.x, self.display.y)
    love.graphics.setColor(255,255,255,255)
    local currentEntity
    for i, entity in ipairs(entities) do
      if self.cursor_row == i then
        currentEntity = entity
        love.graphics.print('>', self.display.x - 15, self.display.y + (i * 20))
      end
      if entity.__name__ == 'Job' then
        line = entity.description
      elseif entity.__name__ == 'Worker' then
        line = entity.name
      end
      if line then
        love.graphics.print(line, self.display.x, self.display.y + (i * 20))
      end
    end
    if currentEntity then

    end
    love.graphics.pop()
  end
}
