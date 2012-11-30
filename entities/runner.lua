
Runner = class("Runner")
Runner:include({
  name = "Runner",
  position = {x = 1, y = 1},
  highlight = false
})

function Runner:initialize(position)
  self.position = position
end
