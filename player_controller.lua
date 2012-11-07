
require("lib/slither")
require("task")
class "PlayerController" {

  tasks = nil,
  __init__ = function(self)
    tasks = {Task('a task', {0,0})}
  end
}

