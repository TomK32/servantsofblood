

class "Job" {
  text = nil,
  category = nil,
  position = nil,
  priority = 0,
  workers = {},
  position = nil,

  __init__ = function(self, text, category)
    self.text = text
    self.category = category
    self.position = {}
    self.priority = 0
    self.workers = {}
  end,

  -- places where this job happens, e.g. a marked area or a workshop
  addEntity = function(self, entity)
    table.insert(self.entities, entity)
  end,

  addWorker = function(self, worker)
    if not self.workers.includes(worker) then
      table.insert(self.workers, worker)
      worker.addJob(self)
    end
  end,

  to_s = function(self)
    return self.text
  end,

  description = function(self)
    return self.text .. ' is a tough job'
  end
}

