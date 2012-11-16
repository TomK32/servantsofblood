

PlayerController = class("PlayerController")
PlayerController:include({

  tasks = nil,
  initialize = function(self)
    position = {x = 0, y = 0}
  end
})
