
Runner = class("Runner")
Runner:include({
  name = "Runner",
  running = true,
  position = {x = 1, y = 1},
  highlight = false,
})

function Runner:initialize(position, name)
  self.position = position
  self.name = name
  self.running = true
end

