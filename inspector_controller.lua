InspectorController = class("InspectorController", Controller)
InspectorController:include({
  inspector_view = nil,

  control_map = {
    keyboard = {
      on_press = {
        escape = 'escape'
      }
    }
  },

  initialize = function(self, inspector_view)
    self.control_map.keyboard.on_press['return'] = 'selectEntity'
    self.inspector_view = inspector_view
  end,

  selectEntity = function(self)
    self.inspector_view.details = true
  end,

  escape = function(self)
    if self.inspector_view.details == false then
      game_controller.active_controller = game_controller
      game_controller:escape()
    else
      self.inspector_view.details = false
    end
  end
})
