
ListView = class("ListView", View)
ListView:include({
  line_height = 20,
  navigatable = true,
  list_entries = nil,
  current_line = 1,
  display = { x = 420, y = 0, width = 220, height = 300 },

  currentEntry = function(self)
    return self.list_entries[self.current_line]
  end,

  moveCursor = function(self, num)
    self.current_line = self.current_line + num
    if (self.current_line < 1) then
      self.current_line = #self.list_entries
    elseif (self.current_line > #self.list_entries) then
      self.current_line = 1
    end
  end,

  drawContent = function(self)
    self:drawList()
  end,

  drawList = function(self)
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
    if self.current_line and #list > 0 then
      love.graphics.print('>', 0, self.current_line * self.line_height)
    end
  end
})
