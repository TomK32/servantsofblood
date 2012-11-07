

class "Job" {
  description = nil,
  category = nil,
  position = nil,
  priority = 0,
  workers = {},

  __init__ = function(self, description, category)
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
  end
}
