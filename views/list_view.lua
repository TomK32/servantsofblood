
ListView = class("ListView", View)
ListView:include({
  line_height = 20,
  navigatable = true,
  list_entries = nil,
  current_line = 1,
  display = { x = 0, y = 0, width = 148, height = 300 },

  initialize = function(self)
    self.display = {x = 0, y = 0}
  end,

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
    local lines = math.floor(self.display.height / self.line_height) - 2
    for i = 1, lines do
      line = list[i]
      love.graphics.translate(0, self.line_height)
      self:drawLine(i, line)
    end
    love.graphics.pop()
    if self.current_line and #list > 0 then
      love.graphics.print('>', 0, self.current_line * self.line_height)
    end
  end
})
