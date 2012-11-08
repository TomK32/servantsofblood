
-- require('lib/LoveFrames/init')
require('job_status_view')

class "GUIMain" {
  game_state = nil,
  map_view = nil,
  job_status_view = nil,

  __init__ = function(self, game_state)
    self.game_state = game_state
    self.job_status_view = JobStatusView(game_state.jobs)
  end,

  draw = function(self)
    self.map_view:draw()
    self.job_status_view:draw()
  end
}
