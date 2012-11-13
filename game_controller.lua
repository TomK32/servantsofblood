require 'game_state'
class "GameController" {
  game_state = nil,
  gui_view = nil,

  __init__ = function(self, game_state, gui_view)
    self.game_state = game_state
    self.gui_view = gui_view
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
  end,

  escape = function(self)
    self:setFocus('main')
  end,

  jobs = function(self)
    if self.game_state.focus == 'main' then
      self:setFocus('jobs')
    end
  end,

  setFocus = function(self, focus)
    self.game_state.focus = focus
    self.gui_view:setFocus(focus)
  end,

  control_map = {
    keyboard = {
      on_press = {
        d = 'designate',
        k = 'inspect',
        escape = 'escape',
        j = 'jobs'
      }
    }
  }
}
