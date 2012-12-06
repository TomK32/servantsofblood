
StartMenuView = class("StartMenuView", View)

gui.core.style.color.normal.bg = {80,180,80}

function StartMenuView:draw()
  gui.core.draw()
end

function StartMenuView:update(dt)
  gui.group.push{grow = "down", pos = {love.graphics.getWidth() / 2 - 150, love.graphics.getHeight() / 2 - 100}}
  if gui.Button{text = "1 Player"} then
    game_state:start()
    game_state:addPlayer('Player')
  end
  if gui.Button{text = "2 Player"} then
    game_state:start()
    game_state:addPlayer('Player WASD', 'wasd')
    game_state:addPlayer('Player LRDU', 'arrows')
  end
end
