require 'game_state'
class "GameController" {
  game_state = nil,
  views = nil,

  __init__ = function(self, game_state, views)
    self.game_state = game_state
    self.views = views
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
    self.game_state.focus = 'inspector'
  end,

  escape = function(self)
    self.game_state.focus = 'main'
  end,

  jobs = function(self)
    self.game_state.focus = 'jobs'
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
