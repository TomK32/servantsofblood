
Runner = class("Runner")
Runner:include({
  name = "Runner",
  running = true,
  position = {x = 1, y = 1},
  highlight = false,
})

function Runner:initialize(position)
  self.position = position
  self.running = true
end

