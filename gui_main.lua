
-- require('lib/LoveFrames/init')

class "GUIMain" {
  game_state = nil,

  __init__ = function(self, game_state)
    self.game_state = game_state
  end,

  draw = function(self)
    self.map_view:draw()
  end
}
