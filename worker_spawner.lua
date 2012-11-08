
class "WorkerSpawner" {

  names = {'A','B','C'},

  __init__ = function(self)
  end,

  create = function(self)
    return Worker(self.names[math.random(1,#self.names)], {x = 0, y = math.random(10), z = 0})
  end
}
