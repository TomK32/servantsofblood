require 'game_state'
require 'controller'
require 'inspector_controller'

class "GameController" (Controller) {
  game_state = nil,
  gui_view = nil,
  active_controller = self,

  control_map = {
    keyboard = {
      on_press = {
        d = 'designate',
        k = 'inspect',
        escape = 'escape',
        j = 'jobs',
        q = 'quit'
      }
    }
  },

  __init__ = function(self, game_state, gui_view)
    self.game_state = game_state
    self.gui_view = gui_view
    self.active_controller = self
    self.inspector_controller = InspectorController()
  end,

  update = function(self)
  end,

  designate = function(self)
    if self.game_state.focus == 'main' then
      local tile = self.views.map_view:currentTile()
      local jobs = tile:jobs()
      if #jobs > 0 then
        print(tile)
      end
    end
  end,

  inspect = function(self)
    if self.game_state.focus == 'main' then
      self:setFocus('inspector')
    end
    self.active_controller = self.inspector_controller
  end,

  escape = function(self)
    self:setFocus('main')
  end,

  quit = function(self)
    love.event.push('quit')
  end,

  jobs = function(self)
    if self.game_state.focus == 'main' then
      self:setFocus('jobs')
    end
  end,

  setFocus = function(self, focus)
    self.game_state.focus = focus
    self.gui_view:setFocus(focus)
  end
}
