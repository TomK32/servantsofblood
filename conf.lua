require('version')
function love.conf(c)
  c.title = "Cross Country Running - " .. game.version
  c.author = "Thomas R. Koll"
  c.modules.physics = false
  c.screen.width = 1024
  c.screen.height = 640
end

