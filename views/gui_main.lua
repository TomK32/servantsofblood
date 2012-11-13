
require('views/view')
require('views/job_status_view')
require('views/jobs_view')
require('views/map_view')
require('views/menu_view')
require('views/inspector_view')

class "GUIMain" {
  game_state = nil,
  map_view = nil,
  job_status_view = nil,
  jobs_view = nil,
  inspector_view = nil,
  menu_view = nil,
  map_view = nil,

  __init__ = function(self, game_state)
    self.game_state = game_state
    self.menu_view = MenuView()
    self.jobs_view = JobsView(game_state.jobs)
    self.job_status_view = JobStatusView(game_state.jobs)
    self.inspector_view = InspectorView()
    self.map_view = MapView(game_state.map)
  end,

  draw = function(self)
    self.map_view:draw()
    if self.game_state.focus == 'inspector' then
      self.inspector_view.entities = self.map_view:currentTile().entities
      self.inspector_view:draw()
    elseif self.game_state.focus == 'jobs' then
      self.jobs_view:draw()
    else
      self.menu_view:draw()
    end
  end
}
