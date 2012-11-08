
class "WorkerSpawner" {

  first_names = {'Amot','Bitan','Calot', 'Difnatan'},
  last_names = {'Zok', 'Yulkomnek', 'Xixik', 'Weikok'},

  __init__ = function(self)
  end,

  create = function(self)
    return Worker(self:random_name(), {x = math.random(14), y = math.random(10), z = 1})
  end,

  random_name = function(self)
    return (self.first_names[math.random(#self.first_names)] .. ' ' ..
      self.last_names[math.random(#self.last_names)] )
  end
}
