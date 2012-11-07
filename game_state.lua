require('map')

class "GameState" {
  map = nil,
  player = nil,

  __init__ = function(self)
    self.player = PlayerController()
    self.map = Map(30,30)
    self.map:randomize()
  end
}

