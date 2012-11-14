class "InspectorController" (Controller) {
  control_map = {
    keyboard = {
      on_press = {
        i = 'info',
        escape = 'escape'
      }
    }
  },

  escape = function(self)
    game_controller.active_controller = game_controller
    game_controller:escape()
  end
}
