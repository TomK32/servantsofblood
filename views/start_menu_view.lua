
StartMenuView = class("StartMenuView", View)

StartMenuView.mode = {fullscreen = false }

gui.core.style.color.normal.bg = {80,180,80}

function StartMenuView:draw()
  gui.core.draw()
end

function StartMenuView:update(dt)
  gui.group.push({grow = "down", pos = {100, 150}})
  if gui.Button{text = "1 Player"} then
    game_state:start()
    game_state:addPlayer('Player')
  end
  if gui.Button{text = "2 Player"} then
    game_state:start()
    game_state:addPlayer('Player WASD', 'wasd')
    game_state:addPlayer('Player LRDU', 'arrows')
  end
  local i = 0
  while i < 16 do
    i = i + 1
    love.graphics.rectangle('fill', i * math.random(100), i * math.random(100), 16, 16)
  end
  gui.group.push({grow = "down", pos = { 150, -50}})
  modes = love.graphics.getModes()
  table.sort(modes, function(a, b) return a.width*a.height < b.width*b.height end)   -- sort from smallest to largest
  for i, mode in ipairs(modes) do
    if gui.Button({text = mode.width .. 'x' .. mode.height}) then
      love.graphics.setMode(mode.width, mode.height)
    end
  end
  if self.mode.fullscreen then
    text = 'Windowed'
  else
    text = 'Fullscreen'
  end
  if gui.Button({text = text}) then
    self.mode.fullscreen = not self.mode.fullscreen
    love.graphics.setMode(love.graphics.getWidth(), love.graphics.getHeight(), self.mode.fullscreen)
  end
end
