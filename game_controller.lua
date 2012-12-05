require 'game_state'
require 'controller'
require 'inspector_controller'


GameController = class("GameController", Controller)
GameController:include({
  game_state = nil,
  gui_view = nil,
  running_order_dt = 0,

  control_map = {
    keyboard = {
      on_press = {
        escape = 'escape',
      }
    }
  },

  initialize = function(self, game_state, gui_view)
    self.game_state = game_state
    self.gui_view = gui_view
    self.active_controller = self
    self.inspector_controller = InspectorController(gui_view.inspector_view)
    self.control_map.keyboard.on_press[' '] = 'toggleGameStatePaused'
  end,

  update = function(self, dt)
    self.game_state.player:update(dt)
    for i, r in ipairs(self.game_state.runners) do
      r:update(dt)
    end
    if self.running_order_dt > 0.2 then
      self.game_state:updateRunningOrder()
      self.running_order_dt = 0
    else
      self.running_order_dt = self.running_order_dt + dt
    end
  end,

  escape = function(self)
    self:setFocus('main')
  end,

  toggleGameStatePaused = function(self)
    if not self.game_state.started then
      self.game_state.started = true
    end
    self.game_state.paused = self.game_state.paused == false
  end,

  setFocus = function(self, focus)
    self.game_state.focus = focus
    self.gui_view:setFocus(focus)
  end
})
