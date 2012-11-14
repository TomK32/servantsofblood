class "Controller" {
  control_map = {},

  keypressed = function(self, key, unicode)
    local action = self.control_map.keyboard.on_press[key]
    if action then
      if type(action) == "function" then action(self) end
      if type(self[action]) == 'function' then self[action](self) end
    end
  end
}
