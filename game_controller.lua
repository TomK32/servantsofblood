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
    if self.game_state.focus == 'map_view' then
      local tile = self.views.map_view:currentTile()
      local jobs = tile:jobs()
      print(#jobs)
      if #jobs > 0 then
        print(tile)
      end
    end
  end,

  control_map = {
    keyboard = {
      on_press = {
        d = 'designate' -- function(self) if self.focus == 'map_view' then self:designate() end end
      }
    }
  }
}
