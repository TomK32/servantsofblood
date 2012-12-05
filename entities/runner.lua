
Runner = class("Runner")
Runner:include({
  name = "Runner",
  running = true,
  position = {x = 1, y = 1},
  highlight = false,
})

function Runner:initialize(position, name, highlight)
  self.position = position
  self.name = name
  self.running = true
  self.highlight = highlight
end

