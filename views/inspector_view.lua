require('views/detail_menu_view')

class "InspectorView" (ListView) {
  entities = nil,
  details = false,
  details_menu_view = nil,

  __init__ = function(self)
    self.entities = {}
    self.details = false
    self.details_menu_view = DetailMenuView(self.details_menu)
    self.details_menu_view.display.y = self.display.height - 100
  end,

  reset = function(self)
    self.current_line = 1
    self.details = false
  end,

  drawContent = function(self)
    self:drawList()
    if self.details then
      self:drawDetails()
    end
  end,

  drawDetails = function(self)
    local entry = self:currentEntry()
    if entry then
      love.graphics.print(self:currentEntry():description(), 0,  140)
      if self.details_menu_view:setLevel(entry.__name__) then
        self.details_menu_view:draw()
      end
    else
      self.details = false
    end
  end,

  drawLine = function(self, line_number, entity)
    love.graphics.setColor(255,255,255,255)
    if entity.to_s and entity:to_s() then
      love.graphics.print(entity:to_s(), 20, 0)
    end
  end
}
