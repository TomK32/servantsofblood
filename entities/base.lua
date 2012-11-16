
Entities = {}

Entities.Base = class("Base")

function Entities.Base:initialize(x, y)
  self.position = {x = x, y = y}
end

function Entities.Base:to_s()
  print(self)
  return self.name
end

function Entities.Base:description()
  return self.name
end
