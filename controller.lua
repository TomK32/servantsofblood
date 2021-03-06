
Controller = class("Controller")
Controller:include({
  control_map = {},

  keypressed = function(self, key, unicode)
    local action = self.control_map.keyboard.on_press[key]
    if action then
      if type(action) == "function" then
        action(self)
      else
        self[action](self)
      end
    end
  end
})
